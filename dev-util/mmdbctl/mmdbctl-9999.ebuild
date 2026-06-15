# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo git-r3 go-module shell-completion

DESCRIPTION="An MMDB file management CLI"
HOMEPAGE="https://github.com/ipinfo/mmdbctl"
EGIT_REPO_URI="https://github.com/ipinfo/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"

DOCS=( {CHANGELOG,README}.md )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	ego build

	local completion
	for completion in bash fish zsh ; do
		edo ./mmdbctl completion ${completion} > mmdbctl.${completion}
	done
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin mmdbctl

	newbashcomp mmdbctl.bash mmdbctl
	newfishcomp mmdbctl.fish mmdbctl
	newzshcomp mmdbctl.zsh _mmdbctl
}
