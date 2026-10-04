# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMMIT="c4dcae6eef54849502fe5abaae89c0250356c6a5"
MY_PN="App-Folder"

DESCRIPTION="App folder widgets for KDE Plasma panels"
HOMEPAGE="https://github.com/IsseyShiitake/App-Folder"
SRC_URI="https://github.com/IsseyShiitake/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

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
