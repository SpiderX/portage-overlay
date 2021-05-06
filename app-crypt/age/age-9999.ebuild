# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/FiloSottile/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Simple, modern and secure encryption tool"
HOMEPAGE="https://github.com/FiloSottile/age"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	go build ./cmd/age || die "build failed"
}

src_test() {
	go test || die "test failed"
}

src_install() {
	einstalldocs
	dobin age
}
