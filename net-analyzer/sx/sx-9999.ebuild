# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/v-byte-cpu/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Fast, modern, easy-to-use network scanner"
HOMEPAGE="https://github.com/v-byte-cpu/sx"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="net-libs/libpcap"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-X main.version=${PV}"
	go build -v -ldflags "${LDFLAGS}" || die "build failed"
}

src_test() {
	go test || die "test failed"
}

src_install() {
	einstalldocs
	dobin sx
}
