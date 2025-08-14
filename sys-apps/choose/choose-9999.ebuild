# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3

DESCRIPTION="Fast alternative to cut and awk"
HOMEPAGE="https://github.com/theryangeary/choose"
EGIT_REPO_URI="https://github.com/theryangeary/${PN}.git"

LICENSE="GPL-3+ MIT Unicode-DFS-2016"
SLOT="0"

DOCS=( readme.md )

QA_FLAGS_IGNORED="usr/bin/choose"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_test() {
	emake test
}

src_install() {
	einstalldocs
	cargo_src_install
}
