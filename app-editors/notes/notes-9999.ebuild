# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Note taking application, write down your thoughts"
HOMEPAGE="https://github.com/nuttyartist/notes"
EGIT_REPO_URI="https://github.com/nuttyartist/${PN}.git"

LICENSE="MPL-2.0"
SLOT="0"

RDEPEND="dev-qt/qtbase:6[concurrent,gui,network,sql,widgets]
	dev-qt/qtdeclarative:6"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/"${PN}"-2.3.1-license.patch )

src_configure() {
	local mycmakeargs=(
		-DGIT_REVISION=ON
		-DUPDATE_CHECKER=OFF
	)
	cmake_src_configure
}
