# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3

DESCRIPTION="Image similarity comparison simulating human perception"
HOMEPAGE="https://github.com/kornelski/dssim"
EGIT_REPO_URI="https://github.com/kornelski/${PN}.git"

LICENSE="AGPL-3 Apache-2.0 BSD BSD-2 CC0-1.0 GPL-3+ MIT MPL-2.0 Unicode-3.0 ZLIB"
SLOT="0"
RESTRICT="mirror"

QA_FLAGS_IGNORED="usr/bin/dssim"

src_unpack() {
	git-r3_src_unpack
	cargo_src_unpack
}

src_install() {
	einstalldocs
	cargo_src_install
}
