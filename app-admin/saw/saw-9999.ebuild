# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/TylerBrock/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Fast, multi-purpose tool for AWS CloudWatch Logs"
HOMEPAGE="https://github.com/TylerBrock/saw"

LICENSE="MIT"
SLOT="0"

DOCS=( {CHANGELOG,README}.md )

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
	dobin saw
}
