# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/digitalocean/${PN}"
EGIT_REPO_URI="https://${EGO_PN}.git"

inherit git-r3 go-module

DESCRIPTION="A command line tool for DigitalOcean services"
HOMEPAGE="https://github.com/digitalocean/doctl"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

BDEPEND=">=dev-lang/go-1.13"

src_unpack() {
	git-r3_src_unpack
}

src_compile() {
	GOFLAGS="-v -x -mod=vendor" \
		go build ./cmd/... || die "build failed"
}

src_test() {
	GOFLAGS="-v -x -mod=vendor" \
		go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin doctl
}
