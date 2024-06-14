# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/dbcrossbar/${PN}.git"

inherit cargo git-r3

DESCRIPTION="Copy tabular data between databases, CSV files and cloud storage"
HOMEPAGE="https://www.dbcrossbar.org"

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 Boost-1.0 CC0-1.0 ISC MIT MPL-2.0 Unicode-DFS-2016 Unlicense ZLIB"
SLOT="0"

DOCS=( {CHANGELOG,DESIGN,README}.md )

QA_FLAGS_IGNORED="usr/bin/dbcrossbar"

src_unpack() {
	git-r3_src_unpack
	cargo_src_unpack
}

src_install() {
	einstalldocs
	cargo_src_install
}
