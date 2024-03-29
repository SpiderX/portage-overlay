# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/luhring/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Utility to import/export data from HashiCorp Vault"
HOMEPAGE="https://github.com/Jimdo/yaml-vault"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

DOCS=( {README,History}.md )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-X main.version=${PV}"
	GOFLAGS="-v -x -mod=vendor" \
		go build -ldflags "$LDFLAGS" || die "build failed"
}

src_test() {
	GOFLAGS="-v -x -mod=vendor" \
		go test -work || die "test failed"
}

src_install() {
	einstalldocs
	dobin yaml-vault
}
