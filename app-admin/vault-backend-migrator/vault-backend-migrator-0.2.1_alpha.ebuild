# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

MY_PV="${PV//_alpha/-dev}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Tool to migrate data across vault clusters"
HOMEPAGE="https://github.com/adamdecaf/vault-backend-migrator"
SRC_URI="https://github.com/adamdecaf/${PN}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="BSD MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

PATCHES=( "${FILESDIR}/${P}-go.sum.patch" )

src_compile() {
	GOFLAGS="-v -x -mod=vendor" \
		go build -o vault-backend-migrator || die "build failed"
}

src_test() {
	GOFLAGS="-v -x -mod=vendor" \
		go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin vault-backend-migrator
}
