# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/peco/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Simplistic interactive filtering tool"
HOMEPAGE="https://github.com/peco/peco"
SRC_URI=""

LICENSE="Apache-2.0 BSD BSD-2 MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DOCS=( {Changes,README.md} )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	go build ./cmd/... || die "build failed"
}

src_test() {
	go test ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin peco
}
