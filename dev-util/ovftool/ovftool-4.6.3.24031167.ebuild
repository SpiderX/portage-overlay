# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit multilib-build pax-utils

MY_PV="$(ver_rs 3 -)"
MY_P="VMware-${PN}-${MY_PV}-lin.x86_64.zip"

DESCRIPTION="VMware Open Virtualization Format tool"
HOMEPAGE="https://developer.broadcom.com/tools/open-virtualization-format-ovf-tool"
SRC_URI="${MY_P}"
S="${WORKDIR}/${PN}"

LICENSE="vmware"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist fetch mirror"

RDEPEND="virtual/libcrypt:0=[${MULTILIB_USEDEP}]"
BDEPEND="app-arch/unzip"

DOCS=( README.txt )

QA_PREBUILT="opt/vmware-ovftool/libcares.so.2
	opt/vmware-ovftool/libcrypto.so.3
	opt/vmware-ovftool/libcurl.so.4
	opt/vmware-ovftool/libexpat.so
	opt/vmware-ovftool/libgcc_s.so.1
	opt/vmware-ovftool/libgoogleurl.so.59
	opt/vmware-ovftool/libicudata.so.60
	opt/vmware-ovftool/libicuuc.so.60
	opt/vmware-ovftool/libssl.so.3
	opt/vmware-ovftool/libssoclient.so
	opt/vmware-ovftool/libstdc++.so.6
	opt/vmware-ovftool/libvim-types.so
	opt/vmware-ovftool/libvmacore.so
	opt/vmware-ovftool/libvmomi.so
	opt/vmware-ovftool/libxerces-c-3.2.so
	opt/vmware-ovftool/libz.so.1
	opt/vmware-ovftool/ovftool.bin"

pkg_nofetch() {
	einfo "Please download ${MY_P} from"
	einfo "${HOMEPAGE}"
	einfo "and place it into your DISTDIR directory"
}

src_prepare() {
	default

	# define path
	sed -i '/^PRGDIR/s|"$PRG"|/opt/vmware-ovftool/ovftool|' ovftool \
		|| die "sed failed for ovftool"
}

src_install() {
	einstalldocs

	insinto /opt/vmware-ovftool
	exeinto /opt/vmware-ovftool
	doins -r certs/ env/ schemas/ manifest.xml icudt44l.dat
	doexe lib* ovftool ovftool.bin

	dosym ../vmware-ovftool/ovftool opt/bin/ovftool

	pax-mark -m "${ED}"/vmware-ovftool/ovftool.bin
}
