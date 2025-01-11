# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/barnybug/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Command line tool for Amazon Route 53"
HOMEPAGE="https://github.com/barnybug/cli53"

LICENSE="Apache-2.0 BSD BSD-2 MIT"
SLOT="0"

DOCS=( {CHANGELOG,README}.md )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_test() {
	ego test -work
}

src_install() {
	einstalldocs
	dobin "${HOME}"/go/bin/cli53
}
