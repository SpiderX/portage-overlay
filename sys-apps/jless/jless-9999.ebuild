# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3

DESCRIPTION="Command-line JSON viewer"
HOMEPAGE="https://github.com/PaulJuliusMartinez/jless"
EGIT_REPO_URI="https://github.com/PaulJuliusMartinez/${PN}.git"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions Boost-1.0 MIT Unicode-DFS-2016 Unlicense"
SLOT="0"
RESTRICT="mirror"

DOCS=( {CHANGELOG,README,SEARCH}.md )

QA_FLAGS_IGNORED="usr/bin/jless"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_install() {
	einstalldocs
	cargo_src_install
}
