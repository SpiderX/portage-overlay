# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit desktop git-r3 qmake-utils

DESCRIPTION="multi-platform GUI for pass, the standard unix password manager"
HOMEPAGE="https://qtpass.org/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/IJHack/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="app-admin/pass
	dev-qt/qtcore:5
	dev-qt/qtgui:5[xcb]
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	net-misc/x11-ssh-askpass"
DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5
	dev-qt/qtsvg:5
	test? ( dev-qt/qttest:5 )"

DOCS=( CHANGELOG.md CONTRIBUTING.md FAQ.md README.md  )

src_prepare() {
	default

	sed -i '/target.path = /s/$$\[QT_INSTALL_TESTS\]/$$PREFIX\$$[QT_INSTALL_TESTS\]/' \
		"${S}"/tests/tests.pri || die "sed for tests.pri failed"
	if ! use test ; then
		sed -i \
			-e '/SUBDIRS += src /s/tests //' \
			-e '/main.depends = /s/tests/src/' \
				"${S}"/qtpass.pro || die "sed for qtpass.pro failed"
	fi
}

src_configure() {
	eqmake5 PREFIX="${D}"/usr
}

src_install() {
	default

	doman ${PN}.1

	insinto /usr/share/applications
	doins "${PN}.desktop"

	newicon artwork/icon.png "${PN}-icon.png"

	insinto /usr/share/appdata
	doins qtpass.appdata.xml
}
