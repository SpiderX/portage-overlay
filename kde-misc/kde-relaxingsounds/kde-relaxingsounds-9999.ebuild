# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/Prayag2/kde_relaxingsounds.git"

inherit ecm git-r3

DESCRIPTION="Plasma 5 widget for play relaxing sounds"
HOMEPAGE="https://github.com/Prayag2/kde_relaxingsounds"
SRC_URI=""

LICENSE="GPL-2"
SLOT="5"
KEYWORDS=""

RDEPEND="kde-plasma/plasma-workspace:5"

src_prepare() {
	default
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/com.github.prayag2.relaxingsounds

	doins package/metadata.json
	doins -r package/contents
}
