# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/augmentable-dev/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Manage your repository's TODOs as config in your codebase"
HOMEPAGE="https://github.com/augmentable-dev/tickgit"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	go build -o tickgit ./cmd/tickgit/tickgit.go || die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin tickgit
}
