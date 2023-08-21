# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/deviceinsight/${PN}.git"

inherit bash-completion-r1 edo git-r3 go-module

DESCRIPTION="Your one stop shop to do anything with Kafka"
HOMEPAGE="https://github.com/twmb/kcl"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

DOCS=( {CHANGELOG,README}.md )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	ego build -buildmode=pie -trimpath -o kcl

	local completion
	for completion in bash zsh ; do
		edo ./kcl misc gen-autocomplete -k"${completion}" > kcl."${completion}"
	done
}

src_install() {
	einstalldocs
	dobin kcl
	newbashcomp kcl.bash kcl
	insinto /usr/share/zsh/site-functions
	newins kcl.zsh _kcl
}
