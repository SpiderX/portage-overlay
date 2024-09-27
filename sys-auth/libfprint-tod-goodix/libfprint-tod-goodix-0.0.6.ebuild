# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit udev

DESCRIPTION="Goodix driver module for libfprint-2 Touch OEM Driver"
HOMEPAGE="https://git.launchpad.net/~oem-solutions-engineers/libfprint-2-tod1-goodix"
SRC_URI="http://dell.archive.canonical.com/updates/pool/public/libf/libfprint-2-tod1-goodix/libfprint-2-tod1-goodix_${PV}.orig.tar.gz"
S="${WORKDIR}/libfprint-2-tod1-goodix-${PV}"

LICENSE="Goodix"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sys-auth/libfprint-tod:2"
RDEPEND="${DEPEND}
	acct-group/plugdev"

QA_PREBUILT="usr/lib64/libfprint-2/tod-1/libfprint-tod-goodix-53xc-0.0.6.so"

src_install() {
	insopts -m 0755
	insinto /usr/"$(get_libdir)"/libfprint-2/tod-1
	doins usr/lib/x86_64-linux-gnu/libfprint-2/tod-1/libfprint-tod-goodix-53xc-"${PV}".so
	udev_dorules lib/udev/rules.d/60-libfprint-2-tod1-goodix.rules
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
