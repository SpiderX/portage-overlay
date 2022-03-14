# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/mozilla/${PN}.git"

inherit bash-completion-r1 git-r3 go-module

DESCRIPTION="Simple and flexible tool for managing secrets"
HOMEPAGE="https://github.com/mozilla/sops"
SRC_URI=""

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS=""

DOCS=( {CHANGELOG,README}.rst )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	go build ./cmd/sops || die "build failed"
}

src_test() {
	go test -work || die "test failed"
}

src_install() {
	einstalldocs
	dobin sops

	newbashcomp "${FILESDIR}"/sops.bash sops
	insinto /usr/share/zsh/site-functions
	newins "${FILESDIR}"/sops.zsh _sops
}
