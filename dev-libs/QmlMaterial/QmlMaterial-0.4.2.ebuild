# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake edo optfeature virtualx

DESCRIPTION="Material Design for QML"
HOMEPAGE="https://github.com/hypengw/QmlMaterial"
SRC_URI="https://github.com/hypengw/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/hypengw/${PN}/raw/refs/heads/main/assets/MaterialSymbolsRounded.wght_400.opsz_24.fill_0.woff2
	https://github.com/hypengw/${PN}/raw/refs/heads/main/assets/MaterialSymbolsRounded.wght_400.opsz_24.fill_1.woff2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="media-libs/freetype[brotli]
	dev-qt/qtbase:6[dbus,gui]
	dev-qt/qtdeclarative:6
	dev-qt/qtshadertools:6"
DEPEND="${RDEPEND}
	test? ( dev-qt/qtbase:6[X] )"
BDEPEND="virtual/pkgconfig"

src_unpack() {
	default

	edo cp -t "${S}/assets" \
		"${DISTDIR}/MaterialSymbolsRounded.wght_400.opsz_24.fill_0.woff2" \
		"${DISTDIR}/MaterialSymbolsRounded.wght_400.opsz_24.fill_1.woff2"
}

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
