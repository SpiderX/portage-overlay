# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/lycheeverse/${PN}.git"

inherit cargo git-r3

DESCRIPTION="Fast, async, stream-based link checker"
HOMEPAGE="https://github.com/lycheeverse/lychee"

LICENSE="0BSD AGPL-3 Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 Boost-1.0 ISC MIT MPL-2.0 Unlicense ZLIB"
SLOT="0"
RESTRICT="mirror test"
PROPERTIES="test_network"

DOCS=( {docs/TROUBLESHOOTING,README}.md lychee.example.toml )

QA_FLAGS_IGNORED="usr/bin/lychee"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_install() {
	einstalldocs
	cargo_src_install --path lychee-bin
}
