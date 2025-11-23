# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo git-r3 go-module shell-completion

DESCRIPTION="Your one stop shop to do anything with Kafka"
HOMEPAGE="https://github.com/twmb/kcl"
EGIT_REPO_URI="https://github.com/twmb/${PN}.git"

LICENSE="BSD"
SLOT="0"

DOCS=( {CHANGELOG,README}.md )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	ego build -o kcl

	local completion
	for completion in bash fish zsh ; do
		edo ./kcl misc gen-autocomplete -k"${completion}" > kcl."${completion}"
	done
}

src_install() {
	einstalldocs
	dobin kcl
	newbashcomp kcl.bash kcl
	newfishcomp kcl.fish kcl
	newzshcomp kcl.zsh _kcl
}
