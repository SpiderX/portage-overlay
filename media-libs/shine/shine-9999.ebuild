# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3

DESCRIPTION="Fixed-point mp3 encoding library"
HOMEPAGE="https://github.com/toots/shine"
SRC_URI=""
EGIT_REPO_URI="https://github.com/toots/${PN}.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""

DOCS=( ChangeLog )

src_prepare() {
	default
	eautoreconf
}
