# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

POSTGRES_COMPAT=( {14..18} )

inherit git-r3 postgres-multi

DESCRIPTION="PostgreSQL extension that requires criteria for UPDATE and DELETE"
HOMEPAGE="https://github.com/eradman/pg-safeupdate"
EGIT_REPO_URI="https://github.com/eradman/${PN}.git"

LICENSE="ISC"
SLOT="0"
RESTRICT="test" # tests needs ephemeralpg

RDEPEND="${POSTGRES_DEP}"
DEPEND="${RDEPEND}"

src_prepare() {
	# fix install
	sed -i '/^PG_CONFIG/d' Makefile || die "sed failed"

	postgres-multi_src_prepare
}
