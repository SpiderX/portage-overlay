# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/mhausenblas/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Simple command-line snippet manager"
HOMEPAGE="https://github.com/mhausenblas/awsometag"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	ego build
}

src_test() {
	ego test -work
}

src_install() {
	einstalldocs
	dobin awsometag
}
