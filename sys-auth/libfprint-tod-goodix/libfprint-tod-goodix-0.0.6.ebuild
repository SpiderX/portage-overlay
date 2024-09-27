# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit udev

DESCRIPTION="Goodix driver module for libfprint-2 Touch OEM Driver"
HOMEPAGE="https://git.launchpad.net/~oem-solutions-engineers/libfprint-2-tod1-goodix"
SRC_URI="https://git.launchpad.net/~oem-solutions-engineers/libfprint-2-tod1-goodix/tree/usr/lib/x86_64-linux-gnu/libfprint-2/tod-1/${PN}-53xc-${PV}.so
	https://git.launchpad.net/~oem-solutions-engineers/libfprint-2-tod1-goodix/tree/lib/udev/rules.d/60-libfprint-2-tod1-goodix.rules"
S="${WORKDIR}"

LICENSE="Goodix"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sys-auth/libfprint-tod:2"
RDEPEND="${DEPEND}
	acct-group/plugdev"

src_unpack() { :; }

src_install() {
	insopts -m 0755
	insinto /usr/"$(get_libdir)"/libfprint-2/tod-1
	doins "${DISTDIR}"/libfprint-tod-goodix-53xc-"${PV}".so
	udev_dorules "${DISTDIR}"/60-libfprint-2-tod1-goodix.rules
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
