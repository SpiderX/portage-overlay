# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/theryangeary/${PN}.git"

inherit cargo git-r3

DESCRIPTION="Fast alternative to cut and awk"
HOMEPAGE="https://github.com/theryangeary/choose"
SRC_URI=""

LICENSE="Apache-2.0 GPL-3+ MIT"
SLOT="0"
KEYWORDS=""

DOCS=( readme.md )

QA_FLAGS_IGNORED="usr/bin/choose"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_test() {
	emake test
}
