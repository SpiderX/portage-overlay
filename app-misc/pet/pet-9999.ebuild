# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module shell-completion

DESCRIPTION="Simple command-line snippet manager"
HOMEPAGE="https://github.com/knqyf263/pet"
EGIT_REPO_URI="https://github.com/knqyf263/${PN}.git"

LICENSE="Apache-2.0 BSD BSD-2 MIT"
SLOT="0"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	emake build
}

src_install() {
	dobin pet
	dozshcomp misc/completions/zsh/_pet
}

pkg_postinst() {
	if ! has_version app-shells/peco && ! has_version app-shells/fzf ; then
		einfo "You should consider to install app-shells/peco or"
		einfo "app-shells/fzf to be able to use selector command"
	fi
}
