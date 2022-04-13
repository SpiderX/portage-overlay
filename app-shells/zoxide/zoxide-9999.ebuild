# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=8

EGIT_REPO_URI="https://github.com/ajeetdsouza/${PN}.git"

inherit bash-completion-r1 cargo git-r3

DESCRIPTION="A smarter cd command with supports of all major shells"
HOMEPAGE="https://github.com/ajeetdsouza/zoxide"
SRC_URI=""

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS=""

DOCS=( {CHANGELOG,README}.md )

QA_FLAGS_IGNORED="usr/bin/zoxide"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_install() {
	einstalldocs
	cargo_src_install

	doman man/zoxide{,-add,-import,-init,-query,-remove}.1
	newbashcomp contrib/completions/zoxide.bash zoxide
	insinto /usr/share/zsh/site-functions
	doins contrib/completions/_zoxide
	insinto /usr/share/fish/vendor_completions.d
	doins contrib/completions/zoxide.fish
}
