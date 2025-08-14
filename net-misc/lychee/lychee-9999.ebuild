# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3

DESCRIPTION="Fast, async, stream-based link checker"
HOMEPAGE="https://github.com/lycheeverse/lychee"
EGIT_REPO_URI="https://github.com/lycheeverse/${PN}.git"

LICENSE="AGPL-3 Apache-2.0 BSD-2 BSD ISC MIT MPL-2.0 Unicode-3.0 ZLIB"
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
