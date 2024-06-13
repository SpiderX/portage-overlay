# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=8

EGIT_REPO_URI="https://github.com/SoptikHa2/${PN}.git"

inherit cargo git-r3

DESCRIPTION="Debugger for Sed"
HOMEPAGE="https://github.com/SoptikHa2/desed"
SRC_URI="${CARGO_CRATE_URIS}"

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions GPL-3+ ISC MIT Unlicense ZLIB"
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
