# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3 shell-completion

DESCRIPTION="An intuitive find and replace tool"
HOMEPAGE="https://github.com/chmln/sd"
EGIT_REPO_URI="https://github.com/chmln/${PN}.git"

LICENSE="Apache-2.0 MIT Unicode-DFS-2016"
SLOT="0"

DOCS=( {CHANGELOG,README}.md )

QA_FLAGS_IGNORED="usr/bin/sd"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_install() {
	einstalldocs
	cargo_src_install

	doman gen/sd.1
	newbashcomp gen/completions/sd.bash sd
	newfishcomp gen/completions/sd.fish sd
	dozshcomp gen/completions/_sd
}
