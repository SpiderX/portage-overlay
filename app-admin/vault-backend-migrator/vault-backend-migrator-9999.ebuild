# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/adamdecaf/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Tool to migrate data across vault clusters"
HOMEPAGE="https://github.com/adamdecaf/vault-backend-migrator"

LICENSE="BSD MIT MPL-2.0"
SLOT="0"

src_unpack() {
	git-r3_src_unpack
}

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
