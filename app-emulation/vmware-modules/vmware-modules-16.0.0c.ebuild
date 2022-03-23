# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info linux-mod udev

MY_KV="4.19"
MY_PV="${PV%*c}"

DESCRIPTION="VMware kernel modules"
HOMEPAGE="https://github.com/mkubecek/vmware-host-modules"
SRC_URI="https://github.com/mkubecek/vmware-host-modules/archive/w${MY_PV}-k${MY_KV}.tar.gz -> ${PN}-${MY_PV}-${MY_KV}.tar.gz"

LICENSE="GPL-2"
SLOT="${MY_KV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="acct-group/vmware"

S="${WORKDIR}/vmware-host-modules-w${MY_PV}-k${MY_KV}"

BUILD_TARGETS="auto-build KERNEL_DIR=${KERNEL_DIR} KBUILD_OUTPUT=${KV_OUT_DIR}"
CONFIG_CHECK="~HIGH_RES_TIMERS VMWARE_VMCI VMWARE_VMCI_VSOCKETS"
MODULE_NAMES="vmmon(misc:${S}/vmmon-only) vmnet(misc:${S}/vmnet-only)"

src_prepare() {
	default

	# Set kernel include dir
	sed -i -e "s%HEADER_DIR = /lib/modules/\$(VM_UNAME)/build/include%HEADER_DIR = ${KERNEL_DIR}/include%" \
		./Makefile || die "sed for Makefile failed"
}

src_install() {
	linux-mod_src_install
	local udevrules="${T}/60-vmware.rules"
	cat > "${udevrules}" <<-EOF
		KERNEL=="vmci",  GROUP="vmware", MODE="660"
		KERNEL=="vmw_vmci",  GROUP="vmware", MODE="660"
		KERNEL=="vmmon", GROUP="vmware", MODE="660"
		KERNEL=="vsock", GROUP="vmware", MODE="660"
	EOF
	udev_dorules "${udevrules}"

	dodir /etc/modprobe.d/
	cat > "${ED}"/etc/modprobe.d/vmware.conf <<-EOF
		# Support for vmware vmci in kernel module
		alias vmci	vmw_vmci
		# Support for vmware vsock in kernel module
		alias vsock	vmw_vsock_vmci_transport
	EOF

	dodir /usr/lib/modules-load.d/
	cat > "${ED}"/usr/lib/modules-load.d/vmware.conf <<-EOF
		vmmon
		vmnet
	EOF
}
