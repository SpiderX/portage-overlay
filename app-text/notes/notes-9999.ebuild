# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/nuttyartist/${PN}.git"

inherit cmake git-r3

DESCRIPTION="Note taking application, write down your thoughts"
HOMEPAGE="https://github.com/nuttyartist/notes"
SRC_URI=""

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="test" # no cmake

RDEPEND="dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtquickcontrols:5
	dev-qt/qtsql:5
	dev-qt/qtwidgets:5"
DEPEND="${RDEPEND}
	test? ( dev-qt/qttest:5 )"

PATCHES=( "${FILESDIR}"/"${PN}"-2.2.1-license.patch )

src_prepare() {
	# specify include to 3rdparty lib
	sed -i '/SOURCES/iinclude ($$PWD/../3rdParty/qautostart/src/qautostart.pri)' \
		tests/tests.pro || die "sed for tests.pro failed"
	# fix typo
	sed -i '/src/s/note/node/' tests/tst_notedata.h || die "sed for tst_notedata.h failed"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUSE_QT_VERSION=5
		-DUPDATE_CHECKER=OFF
	)
	cmake_src_configure
}
