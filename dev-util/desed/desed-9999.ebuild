# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3

DESCRIPTION="Debugger for Sed"
HOMEPAGE="https://github.com/SoptikHa2/desed"
EGIT_REPO_URI="https://github.com/SoptikHa2/${PN}.git"

LICENSE="Apache-2.0 GPL-3+ ISC MIT Unicode-DFS-2016 ZLIB"
SLOT="0"

QA_FLAGS_IGNORED="usr/bin/desed"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_install() {
	einstalldocs
	doman desed.1
	cargo_src_install
}
