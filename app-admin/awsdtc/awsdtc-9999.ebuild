# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/c1982/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="AWS Data Transfer Cost Explorer"
HOMEPAGE="https://github.com/c1982/awsdtc"
SRC_URI=""

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS=""

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	go build || die "build failed"
}

src_test() {
	go test -work || die "test failed"
}

src_install() {
	einstalldocs
	dobin awsdtc
}
