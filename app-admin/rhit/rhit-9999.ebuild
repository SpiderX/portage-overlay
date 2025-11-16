# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3

DESCRIPTION="A nginx log explorer"
HOMEPAGE="https://github.com/Canop/rhit"
EGIT_REPO_URI="https://github.com/Canop/${PN}.git"

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD Boost-1.0 MIT Unicode-DFS-2016 Unlicense ZLIB"
SLOT="0"

DOCS=( {CHANGELOG,README}.md )

QA_PREBUILT="usr/bin/rhit"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_install() {
	einstalldocs
	cargo_src_install
}
