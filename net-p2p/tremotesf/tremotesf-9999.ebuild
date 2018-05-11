# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PLOCALES="en es nl_BE nl ru"
MY_PN="tremotesf2"

inherit git-r3 gnome2-utils l10n qmake-utils xdg-utils

DESCRIPTION="A remote GUI for transmission"
HOMEPAGE="https://github.com/equeim/tremotesf2"
SRC_URI=""
EGIT_REPO_URI="https://github.com/equeim/${MY_PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	kde-frameworks/kwidgetsaddons:5"
DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5"

DOCS=( CHANGELOG.md README.md )

src_prepare() {
	default

	local lr
	lr="$(qt5_get_bindir)"/lrelease
	rm translations/source.ts || die "rm source.ts failed"
	l10n_prepare() {
		$lr translations/"${1}".ts || die "lrelease ${1} failed"
	}
	l10n_find_plocales_changes translations "" .ts
	l10n_for_each_locale_do l10n_prepare
}

src_configure() {
	eqmake5 PREFIX="${ED%/}"/usr
}

src_install() {
	default

	insinto /usr/share/qt5/translations
	doins translations/*.qm
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
