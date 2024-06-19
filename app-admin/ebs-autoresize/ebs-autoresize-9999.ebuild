# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/mpostument/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Automatically resize EBS"
HOMEPAGE="https://github.com/mpostument/ebs-autoresize"

LICENSE="Apache-2.0 BSD BSD-2 MIT MPL-2.0"
SLOT="0"

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
	dobin ebs-autoresize
}
