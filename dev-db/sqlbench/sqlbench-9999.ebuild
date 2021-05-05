# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/felixge/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Measures and compares execution time of one or more SQL queries"
HOMEPAGE="https://github.com/felixge/sqlbench"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
RESTRICT="test" # requires postgresql running

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	go build || die "build failed"
}

src_test() {
	go test || die "test failed"
}

src_install() {
	einstalldocs
	dobin sqlbench
}
