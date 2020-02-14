# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/cli/cli"
EGIT_REPO_URI="https://${EGO_PN}.git"

inherit git-r3 go-module

DESCRIPTION="The GitHub CLI"
HOMEPAGE="https://github.com/cli/cli"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

BDEPEND=">=dev-lang/go-1.13"

src_unpack() {
	git-r3_src_unpack
	mkdir "${S}"/vendor || die "mkdir failed"
	go-module_live_vendor
}

src_compile() {
	export -n GOCACHE XDG_CACHE_HOME
	go build ./cmd/gh/... || die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin gh
}
