# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

COMMIT="83303918cc2ea8cb833d60a4a1114c6ce841395b"

DESCRIPTION="License and vulnerability analysis"
HOMEPAGE="https://github.com/fossas/fossa-cli"
SRC_URI="https://github.com/fossas/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="test" # fails

PATCHES=( "${FILESDIR}/${P}"-go.mod.patch
	"${FILESDIR}/${P}"-go.sum.patch
	"${FILESDIR}/${P}"-modules.txt.patch )

src_compile() {
	local GOVER
	GOVER="$(go version | cut -d' ' -f3)"
	LDFLAGS="-extldflags '-static' -X github.com/fossas/fossa-cli/cmd/fossa/version.version=${PV}
		-X github.com/fossas/fossa-cli/cmd/fossa/version.commit=${COMMIT}
		-X github.com/fossas/fossa-cli/cmd/fossa/version.goversion=${GOVER}
		-X github.com/fossas/fossa-cli/cmd/fossa/version.buildType=development"
	GOFLAGS="-v -x -mod=vendor" \
		go build -o fossa -ldflags="${LDFLAGS}" ./cmd/fossa || die "build failed"
}

src_test() {
	GOFLAGS="-v -x -mod=vendor" \
		go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin fossa
}
