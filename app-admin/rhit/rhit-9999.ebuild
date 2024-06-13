# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=8

EGIT_REPO_URI="https://github.com/Canop/${PN}.git"

inherit cargo git-r3

DESCRIPTION="A nginx log explorer"
HOMEPAGE="https://github.com/Canop/rhit"
SRC_URI="${CARGO_CRATE_URIS}"

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD Boost-1.0 MIT Unicode-DFS-2016 Unlicense ZLIB"

SLOT="0"

DOCS=( {CHANGELOG,README}.md )

QA_PREBUILT="usr/bin/rhit"

src_unpack() {
	git-r3_src_unpack
	cargo_src_unpack
}

src_install() {
	einstalldocs
	cargo_src_install
}
