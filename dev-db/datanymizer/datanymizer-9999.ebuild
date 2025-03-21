# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/datanymizer/${PN}.git"

inherit cargo git-r3

DESCRIPTION="Powerful database anonymizer with flexible rules"
HOMEPAGE="https://github.com/datanymizer/datanymizer"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 Boost-1.0 ISC MIT Unlicense ZLIB"
SLOT="0"

DOCS=( {CHANGELOG,README}.md )

QA_FLAGS_IGNORED="usr/bin/pg_datanymizer"

src_unpack() {
	git-r3_src_unpack
	cargo_src_unpack
}

src_compile() {
	cargo_src_compile --package pg_datanymizer
}

src_install() {
	einstalldocs
	cargo_src_install --path cli/pg_datanymizer
}
