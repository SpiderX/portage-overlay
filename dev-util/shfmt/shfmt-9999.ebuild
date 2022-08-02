# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/mvdan/sh.git"

inherit edo git-r3 go-module

DESCRIPTION="A shell parser, formatter, and interpreter with bash support"
HOMEPAGE="https://github.com/mvdan/sh"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="+man"

BDEPEND="man? ( app-text/scdoc )"

DOCS=( {CHANGELOG,README}.md )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-s -w -X main.version=${PV}"

	ego build -ldflags "${LDFLAGS}" ./cmd/shfmt

	if use man ; then
		edo scdoc < cmd/shfmt/shfmt.1.scd > shfmt.1
	fi
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin shfmt
	use man && doman shfmt.1
}
