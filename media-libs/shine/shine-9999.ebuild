# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="Fixed-point mp3 encoding library"
HOMEPAGE="https://github.com/toots/shine"
EGIT_REPO_URI="https://github.com/toots/${PN}.git"

LICENSE="LGPL-2.1"
SLOT="0"

DOCS=( ChangeLog )

BDEPEND="virtual/pkgconfig"

src_prepare() {
	default
	eautoreconf
}
