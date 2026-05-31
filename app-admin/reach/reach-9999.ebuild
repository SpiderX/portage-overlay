# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="A static network verification tool for AWS"
HOMEPAGE="https://github.com/luhring/reach"
EGIT_REPO_URI="https://github.com/luhring/${PN}.git"

LICENSE="MIT"
SLOT="0"

PATCHES=( "${FILESDIR}/${PN}"-0.2.0-protocol.patch )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	ego build -o ./bin/"${PN}"
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin bin/reach
}
