# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="SVG icons for popular brands"
HOMEPAGE="https://github.com/simple-icons/simple-icons"
EGIT_REPO_URI="https://github.com/simple-icons/${PN}.git"

LICENSE="CC0-1.0"
SLOT="0"

src_install() {
	insinto /usr/share/icons/simple-icons/scalable
	doins -r icons/.
}
