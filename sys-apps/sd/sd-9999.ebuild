# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/chmln/${PN}.git"

inherit bash-completion-r1 cargo git-r3

DESCRIPTION="An intuitive find and replace tool"
HOMEPAGE="https://github.com/chmln/sd"
SRC_URI=""

LICENSE="Apache-2.0 BSD-2 MIT"
SLOT="0"
KEYWORDS=""

DOCS=( {CHANGELOG,README}.md )

QA_FLAGS_IGNORED="usr/bin/sd"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_install() {
	einstalldocs
	cargo_src_install

	# Find generated shell completions and man
	local BUILD_DIR
	BUILD_DIR="$(find target -name sd.bash -print -quit)"

	pushd "${BUILD_DIR%sd.bash}" || die "pushd failed"
	doman sd.1
	newbashcomp sd.bash sd
	insinto /usr/share/fish/vendor_completions.d
	doins sd.fish
	insinto /usr/share/zsh/site-functions
	doins _sd
	popd || die "popd failed"
}
