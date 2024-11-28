# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/eradman/${PN}.git"

inherit git-r3

DESCRIPTION="PostgreSQL extension that requires criteria for UPDATE and DELETE"
HOMEPAGE="https://github.com/eradman/pg-safeupdate"

LICENSE="ISC"
SLOT="0"
RESTRICT="test" # tests needs installed extension

DEPEND="dev-db/postgresql:*"

src_compile() {
	emake USE_PGXS=1
}
