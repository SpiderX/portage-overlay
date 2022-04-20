# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/lycheeverse/${PN}.git"

inherit cargo git-r3

DESCRIPTION="Fast, async, stream-based link checker"
HOMEPAGE="https://github.com/lycheeverse/lychee"
SRC_URI=""

LICENSE="AGPL-3 Apache-2.0 BSD BSD-2 ISC MIT MPL-2.0 ZLIB"
SLOT="0"
KEYWORDS=""
RESTRICT="test"
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
