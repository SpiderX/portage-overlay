# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="Fast, modern, easy-to-use network scanner"
HOMEPAGE="https://github.com/v-byte-cpu/sx"
EGIT_REPO_URI="https://github.com/v-byte-cpu/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="net-libs/libpcap"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-X main.version=${PV}"
	ego build -v -ldflags "${LDFLAGS}"
}

src_test() {
	ego test
}

src_install() {
	einstalldocs
	dobin sx
}
