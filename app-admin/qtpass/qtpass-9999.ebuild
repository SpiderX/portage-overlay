# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/IJHack/${PN}.git"

inherit desktop git-r3 qmake-utils virtualx

DESCRIPTION="multi-platform GUI for pass, the standard unix password manager"
HOMEPAGE="https://qtpass.org"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="app-admin/pass
	dev-qt/qtcore:5
	dev-qt/qtgui:5[xcb]
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	net-misc/x11-ssh-askpass"
DEPEND="${RDEPEND}
	dev-qt/qtsvg:5
	test? ( dev-qt/qttest:5 )"
BDEPEND="dev-qt/linguist-tools:5"

RESTRICT="!test? ( test )"

DOCS=( {CHANGELOG,CONTRIBUTING,FAQ,README}.md )

src_prepare() {
	default

	if ! use test ; then
		sed -i '/SUBDIRS += src /s/tests //' \
			qtpass.pro || die "sed for qtpass.pro failed"
	fi
}

src_configure() {
	eqmake5 PREFIX="${D}"/usr
}

src_test() {
	virtx default
}

src_install() {
	default

	insinto /usr/share/qtpass/translations
	doins localization/*.qm

	doman qtpass.1
	domenu qtpass.desktop
	newicon artwork/icon.png qtpass-icon.png
	insinto /usr/share/appdata
	doins qtpass.appdata.xml
}
