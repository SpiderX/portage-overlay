# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="Distributed transaction framework"
HOMEPAGE="https://github.com/dtm-labs/dtm"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
RESTRICT="test" # need lots databases

DOCS=( README.md conf.sample.yml )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	go build -ldflags="-X main.Version=${PV} -s -w" -trimpath \
		|| die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin dtm
}
