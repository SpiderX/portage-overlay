# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/mozilla/${PN}.git"

inherit git-r3 go-module shell-completion

DESCRIPTION="Simple and flexible tool for managing secrets"
HOMEPAGE="https://github.com/mozilla/sops"

LICENSE="MPL-2.0"
SLOT="0"

DOCS=( {CHANGELOG,README}.rst )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	ego build ./cmd/sops
}

src_test() {
	ego test -work
}

src_install() {
	einstalldocs
	dobin sops

	newbashcomp "${FILESDIR}"/sops.bash sops
	newzshcomp "${FILESDIR}"/sops.zsh _sops
}
