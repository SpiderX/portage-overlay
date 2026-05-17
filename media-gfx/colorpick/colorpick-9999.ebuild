# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Color picker and contrast checker"
HOMEPAGE="https://github.com/qtilities/colorpick"
EGIT_REPO_URI="https://github.com/qtilities/${PN}.git"

LICENSE="BSD"
SLOT="0"

RDEPEND="dev-qt/qtbase:6[widgets]"
BDEPEND="dev-build/qtilitools"

src_prepare() {
	sed -i '/Type=Application/iName=colorpick' \
		resources/freedesktop/application.desktop.in \
		|| die "sed failed for application.desktop.in"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DQTILITIES_USE_DOWNLOAD_TRANSLATIONS=OFF
	)
	cmake_src_configure
}
