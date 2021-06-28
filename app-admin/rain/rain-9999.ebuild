# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/aws-cloudformation/${PN}.git"

inherit bash-completion-r1 git-r3 go-module

DESCRIPTION="A development workflow tool for working with AWS CloudFormation"
HOMEPAGE="https://github.com/aws-cloudformation/rain"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	go build ./cmd/rain || die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin rain

	newbashcomp docs/bash_completion.sh rain
	insinto /usr/share/zsh/site-functions
	newins docs/zsh_completion.sh _rain
}
