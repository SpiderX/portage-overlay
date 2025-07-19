# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="Measures and compares execution time of one or more SQL queries"
HOMEPAGE="https://github.com/felixge/sqlbench"
EGIT_REPO_URI="https://github.com/felixge/${PN}.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # requires postgresql running

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	ego build
}

src_test() {
	ego test
}

src_install() {
	einstalldocs
	dobin sqlbench
}
