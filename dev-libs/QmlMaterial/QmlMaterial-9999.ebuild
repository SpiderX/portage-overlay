# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_LFS=1

inherit cmake edo git-r3 optfeature virtualx

DESCRIPTION="Material Design for QML"
HOMEPAGE="https://github.com/hypengw/QmlMaterial"
EGIT_REPO_URI="https://github.com/hypengw/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="media-libs/freetype[brotli]
	dev-qt/qtbase:6[dbus,gui]
	dev-qt/qtdeclarative:6
	dev-qt/qtshadertools:6"
DEPEND="${RDEPEND}
	test? ( dev-qt/qtbase:6[X] )"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DQM_BUILD_TESTS="$(usex test)"
	)

	cmake_src_configure
}

src_test() {
	local -x QT_QPA_PLATFORM=xcb

	virtx cmake_src_test -j 1
}

pkg_postinst() {
	optfeature "desktop portal integration" sys-apps/xdg-desktop-portal
}
