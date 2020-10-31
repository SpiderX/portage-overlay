# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/adamdecaf/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Tool to migrate data across vault clusters"
HOMEPAGE="https://github.com/adamdecaf/vault-backend-migrator"
SRC_URI=""

LICENSE="BSD MIT MPL-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

src_unpack() {
	git-r3_src_unpack
}

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
