# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="Interactive cryptocurrency monitor"
HOMEPAGE="https://github.com/cointop-sh/cointop"
EGIT_REPO_URI="https://github.com/cointop-sh/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"

src_unpack() {
	git-r3_src_unpack
}

src_compile() {
	GOFLAGS="-v -x -mod=vendor" \
		go build -ldflags "-X github.com/cointop-sh/cointop/cointop.version=${PV}" \
		-o bin/cointop main.go || die "build failed"
}

src_test() {
	GOFLAGS="-v -x -mod=vendor" \
		go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin bin/cointop
}
