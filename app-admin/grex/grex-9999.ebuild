# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=8

EGIT_REPO_URI="https://github.com/pemistahl/${PN}.git"

inherit cargo git-r3

DESCRIPTION="A CLI tool for generating regular expressions"
HOMEPAGE="https://github.com/pemistahl/grex"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions Boost-1.0 MIT Unlicense"
SLOT="0"

DOCS=( {README,RELEASE_NOTES}.md )

QA_FLAGS_IGNORED="usr/bin/grex"

src_unpack() {
	git-r3_src_unpack
	cargo_src_unpack
}

src_install() {
	einstalldocs
	cargo_src_install
}
