# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/jimdo/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Utility to import/export data from HashiCorp Vault"
HOMEPAGE="https://github.com/jimdo/yaml-vault"

LICENSE="Apache-2.0"
SLOT="0"

DOCS=( {README,History}.md )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-X main.version=${PV}"
	GOFLAGS="-v -x -mod=vendor" ego build -ldflags "$LDFLAGS"
}

src_test() {
	GOFLAGS="-v -x -mod=vendor" ego test -work || die "test failed"
}

src_install() {
	einstalldocs
	dobin yaml-vault
}
