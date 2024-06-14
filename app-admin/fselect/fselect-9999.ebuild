# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=8

EGIT_REPO_URI="https://github.com/jhspetersson/${PN}.git"

inherit cargo git-r3

DESCRIPTION="Find files with SQL-like queries"
HOMEPAGE="https://github.com/jhspetersson/fselect"

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 Boost-1.0 CC0-1.0 GPL-2+ ISC MIT MPL-2.0 Unlicense ZLIB"
SLOT="0"
RESTRICT="mirror"

DOCS=( docs/usage.md )

QA_FLAGS_IGNORED="usr/bin/fselect"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_install() {
	einstalldocs
	cargo_src_install
	doman docs/fselect.1
}
