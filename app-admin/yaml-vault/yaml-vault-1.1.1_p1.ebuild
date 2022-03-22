# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Utility to import/export data from HashiCorp Vault"
HOMEPAGE="https://github.com/Jimdo/yaml-vault"
SRC_URI="https://api.github.com/repos/Jimdo/${PN}/tarball/a696961 -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/Jimdo-${PN}-a696961"

DOCS=( {README,History}.md )

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
