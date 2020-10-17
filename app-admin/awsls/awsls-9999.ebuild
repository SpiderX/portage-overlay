# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/jckuester/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="A list command for AWS resources"
HOMEPAGE="https://github.com/jckuester/awsls"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="test" # needs network

BDEPEND="test? ( app-admin/terraform )"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	go build || die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin awsls
}
