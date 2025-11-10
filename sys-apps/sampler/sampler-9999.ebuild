# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="Visualization for any shell command"
HOMEPAGE="https://github.com/sqshq/sampler"
EGIT_REPO_URI="https://github.com/sqshq/${PN}.git"

LICENSE="GPL-3"
SLOT="0"

DEPEND="media-libs/alsa-lib"
RDEPEND="${DEPEND}"

DOCS=( README.md example.yml )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	ego build
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin sampler
}
