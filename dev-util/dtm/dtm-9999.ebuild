# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="Distributed transaction framework"
HOMEPAGE="https://github.com/dtm-labs/dtm"
EGIT_REPO_URI="https://github.com/dtm-labs/${PN}.git"

LICENSE="BSD"
SLOT="0"
RESTRICT="test" # needs a lot of databases

DOCS=( README.md conf.sample.yml )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	ego build -ldflags="-X main.Version=${PV}"
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin dtm
}
