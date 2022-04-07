# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/open-eid/${PN}.git"

inherit cmake git-r3 readme.gentoo-r1

DESCRIPTION="Estonian ID card management desktop utility"
HOMEPAGE="https://github.com/open-eid/qesteidutil https://id.ee/"
SRC_URI=""

LICENSE="LGPL-2.1"
KEYWORDS=""
SLOT="0"
IUSE="+webcheck"
REQUIRED_USE="webcheck" # build fails without it

RDEPEND="dev-libs/openssl:0=
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	dev-qt/qtsingleapplication
	sys-apps/pcsc-lite"
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/linguist-tools:5
	virtual/pkgconfig"

DOCS=( AUTHORS {README,RELEASE-NOTES}.md )

DOC_CONTENTS="You should install app-crypt/ccid to be able to use your reader"

src_prepare() {
	default

	# don't use bundled libs
	sed -i \
		-e '/add_subdirectory( qtsingleapplication )/d' \
		-e '/list( APPEND LIBRARIES/s|qtsingleapplication|Qt5Solutions_SingleApplication-2.6|' \
		common/CMakeLists.txt || die "sed failed for CMakeLists.txt"
	sed -i '/#include "/s|qtsingleapplication/src|QtSolutions|' \
		common/Common.h || die "sed failed for Common.h"
	# fix missing include
	sed -i '/include <QtWidgets\/QMessageBox/a#include <QButtonGroup>' \
		src/MainWindow.cpp || die "sed failed for src/MainWindow.cpp"
	sed -i '/#include <QtGui\/QPainter/a#include <QtGui/QIntValidator>' \
		src/Updater.cpp || die "sed failed for src/Updater.cpp"
	# correct path for appdata
	sed -i '/qesteidutil.appdata.xml/s|/appdata|/metainfo|' CMakeLists.txt \
		|| die "sed failed for CMakeLists.txt"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBREAKPAD=NO
		-DCONFIG_URL="$(usex webcheck 'https://id.eesti.ee/config.json' '')"
	)
	cmake_src_configure
}

src_install() {
	insinto /usr/share/qt5/translations
	doins "${S}"_build/{en,et,ru}.qm

	readme.gentoo_create_doc

	cmake_src_install
}

pkg_postinst() {
	readme.gentoo_print_elog
}
