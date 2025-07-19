# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="Command-line JSON processor for binary data"
HOMEPAGE="https://github.com/wader/fq"
EGIT_REPO_URI="https://github.com/wader/${PN}.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-tcltk/expect )"

DOCS=( {CHANGES,README}.md )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	export CGO_ENABLED=0

	ego build -trimpath -o fq
}

src_test() {
	emake test
}

src_install() {
	einstalldocs
	dobin fq
}
