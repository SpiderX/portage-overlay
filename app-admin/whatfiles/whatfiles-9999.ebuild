# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/spieglt/${PN}.git"

inherit git-r3 toolchain-funcs

DESCRIPTION="Log what files are accessed by any Linux process"
HOMEPAGE="https://github.com/spieglt/whatfiles"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	einstalldocs
	dobin bin/whatfiles
}
