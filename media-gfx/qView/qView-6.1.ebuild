# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils optfeature virtualx xdg

DESCRIPTION="Practical and minimal image viewer"
HOMEPAGE="https://interversehq.com/qview/ https://github.com/jurplel/qView"
SRC_URI="https://github.com/jurplel/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5"
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/linguist-tools:5
	virtual/pkgconfig
	test? ( dev-qt/qttest:5 )"

src_prepare() {
	default

	# Do not install license
	sed -i '/license.files/d' qView.pro \
		|| die "sed failed for qView.pro"
}

src_configure() {
	eqmake5 PREFIX=/usr
}

src_test() {
	pushd tests || die "pushd failed"
	eqmake5
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
	optfeature "Extra image format" dev-qt/qtimageformats
	optfeature "HEIF/HEIC support" media-libs/qt-heif kde-frameworks/kimageformats
	optfeature "SVG support" dev-qt/qtsvg
}
