# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/PaulJuliusMartinez/${PN}.git"

inherit cargo git-r3

DESCRIPTION="Command-line JSON viewer"
HOMEPAGE="https://github.com/PaulJuliusMartinez/jless"
SRC_URI=""

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS=""

DOCS=( {CHANGELOG,README,SEARCH}.md )

QA_FLAGS_IGNORED="usr/bin/jless"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}
