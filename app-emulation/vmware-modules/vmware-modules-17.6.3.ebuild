# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1 udev

COMMIT="7bab658ccb4ba783b984e800a30925eea46448ff"

DESCRIPTION="VMware kernel modules"
HOMEPAGE="https://github.com/bytium/vm-host-modules"
SRC_URI="https://github.com/bytium/vm-host-modules/archive/${COMMIT}.tar.gz -> ${PN}-${COMMIT}.tar.gz"
S="${WORKDIR}/vm-host-modules-${COMMIT}"

LICENSE="GPL-2"
SLOT="${PV%.*}"
KEYWORDS="~amd64 ~x86"

RDEPEND="acct-group/vmware"

CONFIG_CHECK="~HIGH_RES_TIMERS VMWARE_VMCI VMWARE_VMCI_VSOCKETS"

src_configure() {
	export LINUXINCLUDE="${KERNEL_DIR}/include"
}

src_compile() {
	local modlist=( vmmon=misc:vmmon-only vmnet=misc:vmnet-only )
	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install
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

pkg_postinst() {
	linux-mod-r1_pkg_postinst
	udev_reload
}

pkg_postrm() {
	udev_reload
}
