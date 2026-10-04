# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit git-r3

DESCRIPTION="App folder widgets for KDE Plasma panels"
HOMEPAGE="https://github.com/IsseyShiitake/App-Folder"
EGIT_REPO_URI="https://github.com/IsseyShiitake/App-Folder.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-libs/glib:2
	dev-qt/qtdeclarative:6
	kde-frameworks/kirigami:6
	kde-plasma/kde-cli-tools:6
	kde-plasma/kwin:6
	kde-plasma/libplasma:6
	kde-plasma/plasma5support:6
	kde-plasma/plasma-workspace:6"

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/appfolder
	doins -r plasmoid/.
}
