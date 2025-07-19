# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="Finds most often fields in a stream of records"
HOMEPAGE="https://github.com/timbray/topfew"
EGIT_REPO_URI="https://github.com/timbray/${PN}.git"

LICENSE="GPL-3"
SLOT="0"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	ego build -o tf
}

src_test() {
	ego test -v ./...
}

src_install() {
	einstalldocs
	dobin tf
	doman doc/tf.1
}
