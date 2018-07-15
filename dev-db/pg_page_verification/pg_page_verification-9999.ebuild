# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/google/${PN}.git"

inherit git-r3 toolchain-funcs

DESCRIPTION="Checksums verification on PostgreSQL data pages"
HOMEPAGE="https://github.com/google/pg_page_verification"
SRC_URI=""

LICENSE="google"
KEYWORDS=""
SLOT="0"
IUSE=""

DEPEND="dev-db/postgresql:*"

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	einstalldocs
	dobin "${PN}"
}
