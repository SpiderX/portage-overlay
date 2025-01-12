# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/luhring/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="A static network verification tool for AWS"
HOMEPAGE="https://github.com/luhring/reach"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # wrong exit code

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	go build -o ./bin/"${PN}" || die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin bin/reach
}
