# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo git-r3 optfeature qt-utils virtualx

DESCRIPTION="Explore live radio stations on a rotatable globe"
HOMEPAGE="https://github.com/rcspam/radioglobe"
EGIT_REPO_URI="https://github.com/rcspam/${PN}.git"

LICENSE="MIT"
SLOT="0"
IUSE="nodejs test"
REQUIRED_USE="nodejs? ( test )"

RDEPEND="dev-qt/qtdeclarative:6
	kde-frameworks/kcmutils:6
	kde-frameworks/kconfig:6
	kde-frameworks/kdeclarative:6
	kde-frameworks/kiconthemes:6
	kde-frameworks/kirigami:6
	kde-plasma/libplasma:6
	kde-plasma/plasma5support:6
	kde-plasma/plasma-workspace:6
	media-plugins/mpv-mpris
	media-video/mpv"
BDEPEND="test? ( nodejs? ( net-libs/nodejs ) )"

PATCHES=( "${FILESDIR}/${PN}"-0.2.0-mpris-identity.patch )

src_test() {
	QML_XHR_ALLOW_FILE_READ=1 \
		virtx "$(qt_get_broot_binary 6 qmltestrunner)" -input tests/qml
	use nodejs && edo node --test tests/node/*.test.mjs
}

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/com.github.rcspam.radioglobe
	doins -r {contents,metadata.json}
}

pkg_postinst() {
	optfeature "selecting station locations on a map" dev-qt/qtlocation:6
}
