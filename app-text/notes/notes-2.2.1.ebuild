# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake edo

QSU_COMMIT="14c1bef71d26c915eeaa05c988c55bdad98e1d75"
QAS_COMMIT="efdb2e5a25e5646390f8658e3321f6e9a4c3561a"
QMD_COMMIT="c6420c537e219a7b7685f2bbe5e0862af631d91c"

DESCRIPTION="Note taking application, write down your thoughts"
HOMEPAGE="https://github.com/nuttyartist/notes"
SRC_URI="https://github.com/nuttyartist/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/alex-spataru/QSimpleUpdater/archive/${QSU_COMMIT}.tar.gz -> ${P}-qsu.tar.gz
	https://github.com/b00f/qautostart/archive/${QAS_COMMIT}.tar.gz -> ${P}-qas.tar.gz
	https://github.com/pbek/qmarkdowntextedit/archive/${QMD_COMMIT}.tar.gz -> ${P}-qmd.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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

PATCHES=( "${FILESDIR}"/"${P}"-license.patch )

src_prepare() {
	edo rmdir 3rdParty/{QSimpleUpdater,qautostart,qmarkdowntextedit}
	edo ln -s ../../QSimpleUpdater-"${QSU_COMMIT}" \
		3rdParty/QSimpleUpdater
	edo ln -s ../../qautostart-"${QAS_COMMIT}" \
		3rdParty/qautostart
	edo ln -s ../../qmarkdowntextedit-"${QMD_COMMIT}" \
		3rdParty/qmarkdowntextedit

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
