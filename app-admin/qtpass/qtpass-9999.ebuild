# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/IJHack/${PN}.git"

inherit desktop git-r3 qmake-utils

DESCRIPTION="Multi-platform GUI for pass, the standard unix password manager"
HOMEPAGE="https://qtpass.org"

LICENSE="GPL-3"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="|| ( app-admin/pass app-admin/gopass )
	dev-qt/qtbase:6[gui,network,widgets]
	net-misc/x11-ssh-askpass"
DEPEND="${RDEPEND}
	dev-qt/qtsvg:6"
BDEPEND="dev-qt/qttools:6[linguist]"

DOCS=( {CHANGELOG,FAQ,README}.md )

src_prepare() {
	default

	if ! use test ; then
		sed -i '/SUBDIRS += src /s/tests //' \
			qtpass.pro || die "sed for qtpass.pro failed"
	fi
}

src_configure() {
	eqmake6 PREFIX="${EPREFIX}"/usr
}

src_test() {
	local -x QT_QPA_PLATFORM=offscreen
	default
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	einstalldocs

	insinto /usr/share/qtpass/translations
	doins src/.qm/*.qm

	doman qtpass.1
	domenu qtpass.desktop
	newicon artwork/icon.png qtpass-icon.png
	insinto /usr/share/metainfo
	doins qtpass.appdata.xml
}
