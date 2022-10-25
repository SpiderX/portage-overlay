# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/nuttyartist/${PN}.git"

inherit desktop git-r3 qmake-utils virtualx

DESCRIPTION="Note taking application, write down your thoughts"
HOMEPAGE="https://github.com/nuttyartist/notes"
SRC_URI=""

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtsql:5
	dev-qt/qtwidgets:5"
DEPEND="${RDEPEND}
	test? ( dev-qt/qttest:5 )"

src_prepare() {
	default

	if use test ; then
		sed -i '/SUBDIRS/s|$| tests|' \
			Project.pro || die "sed for Project.pro failed"
	fi

	# specify include to 3rdparty lib
	sed -i '/SOURCES/iinclude ($$PWD/../3rdParty/qautostart/src/qautostart.pri)' \
		tests/tests.pro || die "sed for tests.pro failed"
	# fix typo
	sed -i '/src/s/note/node/' tests/tst_notedata.h || die "sed for tst_notedata.h failed"
}

src_configure() {
	eqmake5 PREFIX="${EPREFIX}"/usr
}

src_test() {
	virtx default
}

src_install() {
	einstalldocs
	emake INSTALL_ROOT="${ED}" install

	domenu packaging/linux/common/notes.desktop
	for size in 16 22 24 32 48 64 128 256 512 ; do
		doicon -s "${size}" packaging/linux/common/icons/"${size}x${size}"/notes.png
	done
	doicon -s scalable packaging/linux/common/icons/scalable/notes.svg
	dosym ../icons/hicolor/512x512/apps/notes.png /usr/share/pixmaps/notes.png
}
