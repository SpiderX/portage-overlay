# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/enky-marte/${PN}.git"

inherit ecm git-r3

DESCRIPTION="Plasma 5 widget for quick access to favorite folders"
HOMEPAGE="https://github.com/enky-marte/plasma-applet-favoriteFolders"
SRC_URI=""

LICENSE="GPL-2"
SLOT="5"
KEYWORDS=""

RDEPEND="kde-plasma/plasma-workspace:5"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/favoriteFolders

	doins package/metadata.desktop
	doins -r package/contents
}
