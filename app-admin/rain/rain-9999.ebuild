# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module shell-completion

DESCRIPTION="A development workflow tool for working with AWS CloudFormation"
HOMEPAGE="https://github.com/aws-cloudformation/rain"
EGIT_REPO_URI="https://github.com/aws-cloudformation/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	ego build ./cmd/rain
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin rain

	newbashcomp docs/bash_completion.sh rain
	newzshcomp docs/zsh_completion.sh _rain
}
