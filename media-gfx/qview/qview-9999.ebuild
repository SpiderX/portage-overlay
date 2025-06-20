# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2317

EAPI=8

PLOCALES="bg bn de es fr hr hu id is it ja kmr ko nb_NO nl pl pt_BR pt_PT pt ru sl sv tr uk zh_Hans zh_Hant"
PLOCALE_BACKUP="en"

inherit git-r3 qmake-utils optfeature plocale virtualx xdg

DESCRIPTION="Practical and minimal image viewer"
HOMEPAGE="https://interversehq.com/qview/ https://github.com/jurplel/qView"
EGIT_REPO_URI="https://github.com/jurplel/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
IUSE="X"
RESTRICT="test" # broken on qt6

RDEPEND="dev-qt/qtbase:6[gui,network,widgets]
	X? ( x11-libs/libX11 )"
BDEPEND="dev-qt/qttools[linguist]
	virtual/pkgconfig"

src_prepare() {
	default

	# do not install license
	sed -i '/license.files/d' qView.pro \
		|| die "sed failed for qView.pro"

	my_rm_loc() {
		rm i18n/qview_"${1}".ts || die "rm failed for locale/qview_${1}.ts"
	}
	plocale_for_each_disabled_locale my_rm_loc
}

src_configure() {
	eqmake6 CONFIG+="$(usex X '' NO_X11)" PREFIX="${EPREFIX}"/usr
}

src_test() {
	pushd tests || die "pushd failed"
	eqmake6
	emake
	virtx ./tests
	popd || die "popd failed"
}

src_install() {
	einstalldocs
	emake INSTALL_ROOT="${ED}" install
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update

	optfeature "animated PNG" media-libs/QtApng
	optfeature "Extra image format" dev-qt/qtimageformats:6
	optfeature "HEIF/HEIC support" media-libs/qt-heif kde-frameworks/kimageformats:6
	optfeature "SVG support" dev-qt/qtsvg:6
}
