# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/digitalocean/${PN}"

inherit go-module

DESCRIPTION="A command line tool for DigitalOcean services"
HOMEPAGE="https://github.com/digitalocean/doctl"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

BDEPEND=">=dev-lang/go-1.13"

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
