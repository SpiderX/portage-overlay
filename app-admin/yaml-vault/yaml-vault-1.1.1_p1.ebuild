# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

COMMIT="a696961003ab9bca89129f08f56dd02541065a16"

DESCRIPTION="Utility to import/export data from HashiCorp Vault"
HOMEPAGE="https://github.com/Jimdo/yaml-vault"
SRC_URI="https://github.com/Jimdo/${PN}/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( {README,History}.md )

src_compile() {
	LDFLAGS="-X main.version=${PV}"
	GOFLAGS="-v -x -mod=vendor" ego build -ldflags "$LDFLAGS"
}

src_test() {
	GOFLAGS="-v -x -mod=vendor" ego test -work
}

src_install() {
	einstalldocs
	dobin yaml-vault
}
