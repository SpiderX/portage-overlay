# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

MY_PV="${PV//_alpha/-dev}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Tool to migrate data across vault clusters"
HOMEPAGE="https://github.com/adamdecaf/vault-backend-migrator"
SRC_URI="https://github.com/adamdecaf/${PN}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PATCHES=( "${FILESDIR}/${P}-go.sum.patch" )

src_compile() {
	ego build -o vault-backend-migrator
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin vault-backend-migrator
}
