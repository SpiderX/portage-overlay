# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multilib-build pax-utils

MY_PV="$(ver_rs 3 -)"
MY_P="VMware-${PN}-${MY_PV}-lin._arch_.bundle"

DESCRIPTION="VMware Open Virtualization Format tool"
HOMEPAGE="https://developer.vmware.com/tools"
SRC_URI="amd64? ( ${MY_P/_arch_/x86_64} )"
#	arm64? ( ${MY_P/_arch_/x86_64} )
#	x86? ( ${MY_P/_arch_/i386} )"

LICENSE="vmware"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64 ~x86"
RESTRICT="bindist fetch mirror"

BDEPEND="sys-libs/ncurses-compat:5[${MULTILIB_USEDEP}]"

DOCS=( src/vmware-ovftool/README.txt )

S="${WORKDIR}"

QA_PREBUILT="opt/vmware-ovftool/libssl.so.1.0.2
	opt/vmware-ovftool/libxerces-c-3.2.so
	opt/vmware-ovftool/libvmacore.so
	opt/vmware-ovftool/libgoogleurl.so.59
	opt/vmware-ovftool/libicuuc.so.60
	opt/vmware-ovftool/libicudata.so.60
	opt/vmware-ovftool/libssoclient.so
	opt/vmware-ovftool/libvim-types.so
	opt/vmware-ovftool/libcrypto.so.1.0.2
	opt/vmware-ovftool/libz.so.1
	opt/vmware-ovftool/libstdc++.so.6
	opt/vmware-ovftool/libvmomi.so
	opt/vmware-ovftool/ovftool.bin
	opt/vmware-ovftool/libcares.so.2
	opt/vmware-ovftool/libcurl.so.4
	opt/vmware-ovftool/libicuuc.so.58
	opt/vmware-ovftool/libexpat.so
	opt/vmware-ovftool/libgcc_s.so.1"

pkg_nofetch() {
	einfo "Please download ${MY_P/_arch_/x86_64} or"
	einfo "${MY_P/_arch_/i386} from"
	einfo "${HOMEPAGE}"
	einfo "and place it into your DISTDIR directory"
}

src_unpack() {
	# Bundle doesn't allow extraction via symlinks or relative paths
	if use amd64 ; then
		cp "${DISTDIR}"/"${MY_P/_arch_/x86_64}" "${S}"/ || die "cp amd64 failed"
		sh "${S}"/"${MY_P/_arch_/x86_64}" --console --required --eulas-agreed -x "${S}/src" \
			|| die "extract amd64 failed"
	fi
	if use arm64 ; then
		cp "${DISTDIR}"/"${MY_P/_arch_/arm64}" "${S}"/ || die "cp amd64 failed"
		sh "${S}"/"${MY_P/_arch_/arm64}" --console --required --eulas-agreed -x "${S}/src" \
			|| die "extract arm64 failed"
	fi
	if use x86 ; then
		cp "${DISTDIR}"/"${MY_P/_arch_/x86_64}" "${S}"/ || die "cp x86 failed"
		sh "${DISTDIR}"/"${MY_P/_arch_/i386}" --console --required --eulas-agreed -x "${S}/src" \
			|| die "extract x86 failed"
	fi
}

src_install() {
	einstalldocs

	insinto /opt/vmware-ovftool
	exeinto /opt/vmware-ovftool
	doins -r src/vmware-ovftool/certs/ src/vmware-ovftool/env/ \
		src/vmware-ovftool/schemas/ src/vmware-ovftool/manifest.xml \
		src/vmware-ovftool/icudt44l.dat
	doexe src/vmware-ovftool/lib* src/vmware-ovftool/ovftool \
		src/vmware-ovftool/ovftool.bin

	echo "PATH=\"/opt/vmware-ovftool/\"" > "${T}"/99ovftool
	doenvd "${T}"/99ovftool

	pax-mark -m "${ED}"/vmware-ovftool/ovftool.bin
}
