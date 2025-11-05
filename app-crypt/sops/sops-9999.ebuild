# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo git-r3 go-module shell-completion

DESCRIPTION="Simple and flexible tool for managing secrets"
HOMEPAGE="https://github.com/mozilla/sops"
EGIT_REPO_URI="https://github.com/mozilla/${PN}.git"

LICENSE="MPL-2.0"
SLOT="0"

DOCS=( {CHANGELOG,README}.rst )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	ego build ./cmd/sops

	local completion
	for completion in bash zsh ; do
		edo ./sops completion "${completion}" > sops."${completion}"
	done
}

src_test() {
	ego test -work
}

src_install() {
	einstalldocs
	dobin sops

	insinto /usr/share/sops
	doins audit/schema.sql

	newbashcomp sops.bash sops
	newzshcomp sops.zsh _sops
}
