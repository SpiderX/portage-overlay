# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="Split ping, shows direction the loss or latency is on"
HOMEPAGE="https://github.com/benjojo/sping"
EGIT_REPO_URI="https://github.com/benjojo/${PN}.git"

LICENSE="Apache-2.0 BSD BSD-2 MIT"
SLOT="0"

src_unpack() {
	git-r3_src_unpack
}

src_compile() {
	GOFLAGS="-v -x -mod=vendor" ego build
}

src_test() {
	GOFLAGS="-v -x -mod=vendor" ego test -work
}

src_install() {
	einstalldocs
	dobin sping
}
