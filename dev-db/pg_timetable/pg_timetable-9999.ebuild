# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="Advanced scheduling for PostgreSQL"
HOMEPAGE="https://github.com/cybertec-postgresql/pg_timetable"
EGIT_REPO_URI="https://github.com/cybertec-postgresql/${PN}.git"

LICENSE="POSTGRESQL"
SLOT="0"
RESTRICT="test" # need database

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	ego build
}

src_test() {
	ego test -v -work ./...
}

src_install() {
	einstalldocs
	dobin pg_timetable
}
