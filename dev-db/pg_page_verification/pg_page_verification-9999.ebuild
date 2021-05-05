# Copyright 1999-2021 Gentoo Authors
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

DEPEND="<dev-db/postgresql-12:*"

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	einstalldocs
	dobin pg_page_verification
}
