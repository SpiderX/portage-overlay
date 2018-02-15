# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils

DESCRIPTION="A cross-platform IRC framework written with Qt"
HOMEPAGE="https://github.com/communi/communi-desktop"
SRC_URI="https://github.com/communi/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/communi/${PN/desktop/shared}/archive/v${PV}.tar.gz -> ${PN/desktop/shared}-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug gnome"

RDEPEND="dev-libs/libcommuni
	dev-qt/qtdbus:5
	dev-qt/qtmultimedia:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	gnome? (
		dev-libs/glib:2
		dev-qt/qtx11extras:5
		)"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS README.md )

src_prepare() {
	default

	rmdir src/libs/base/shared || die "rmdir shared failed"
	mv ../"${PN/desktop/shared}"-"${PV}" src/libs/base/shared \
		|| die "move communi-shared failed"

	if ! use gnome ; then
		sed -i '/else:qtHaveModule(x11extras)/d' \
			src/plugins/plugins.pro || die "sed failed for plugins.pro"
	fi
}

src_configure() {
	eqmake5 COMMUNI_INSTALL_LIBS="/usr/$(get_libdir)" \
		-config no_rpath \
		-config "$(usex debug debug release)"
}

src_install() {
	einstalldocs
	emake install INSTALL_ROOT="${D}"
}
