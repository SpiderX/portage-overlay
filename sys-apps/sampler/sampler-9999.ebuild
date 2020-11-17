# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/sqshq/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Visualization for any shell command"
HOMEPAGE="https://github.com/sqshq/sampler"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="media-libs/alsa-lib"
RDEPEND="${DEPEND}"

DOCS=( README.md example.yml )

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
	dobin sampler
}
