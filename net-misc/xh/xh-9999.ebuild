# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3 shell-completion

DESCRIPTION="Friendly and fast tool for sending HTTP requests"
HOMEPAGE="https://github.com/ducaale/xh"
EGIT_REPO_URI="https://github.com/ducaale/${PN}.git"

LICENSE="Apache-2.0 BSD ISC MIT MPL-2.0 Unicode-3.0"
SLOT="0"
RESTRICT="test"
PROPERTIES="test_network"

DOCS=( {CHANGELOG,README}.md )

QA_FLAGS_IGNORED="usr/bin/xh"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_install() {
	einstalldocs
	cargo_src_install

	doman doc/xh.1
	newbashcomp completions/xh.bash xh
	dozshcomp completions/_xh
	newfishcomp completions/xh.fish xh
}
