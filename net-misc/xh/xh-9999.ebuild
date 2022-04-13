# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=8

EGIT_REPO_URI="https://github.com/ducaale/${PN}.git"

inherit bash-completion-r1 cargo git-r3

DESCRIPTION="Friendly and fast tool for sending HTTP requests"
HOMEPAGE="https://github.com/ducaale/xh"
SRC_URI=""

LICENSE="Apache-2.0 BSD ISC MIT MPL-2.0 ZLIB"
SLOT="0"
KEYWORDS=""
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
	insinto /usr/share/zsh/site-functions
	doins completions/_xh
	insinto /usr/share/fish/vendor_completions.d
	doins completions/xh.fish
}
