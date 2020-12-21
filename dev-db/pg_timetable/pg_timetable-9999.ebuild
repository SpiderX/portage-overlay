# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/cybertec-postgresql/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Advanced scheduling for PostgreSQL"
HOMEPAGE="https://github.com/cybertec-postgresql/pg_timetable"
SRC_URI=""

LICENSE="POSTGRESQL"
SLOT="0"
KEYWORDS=""
IUSE=""
RESTRICT="test" # need database

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	go build || die "build failed"
}

src_test() {
	go test -v -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin pg_timetable
}
