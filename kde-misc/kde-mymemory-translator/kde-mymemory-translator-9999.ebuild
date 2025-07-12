# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm git-r3

DESCRIPTION="Plasmoid for translation using the mymemory translated api"
HOMEPAGE="https://github.com/zayronxio/Kde.mymemory.translator"
EGIT_REPO_URI="https://github.com/zayronxio/Kde.mymemory.translator.git"

LICENSE="MIT"
SLOT="6"

RDEPEND="kde-frameworks/kdeclarative:6
	kde-frameworks/ki18n:6
	kde-plasma/plasma-workspace:6"

src_prepare() {
	default
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/kde.mymemory.translator
	doins -r contents metadata.json
}
