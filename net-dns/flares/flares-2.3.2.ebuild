# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="CloudFlare DNS backup tool"
HOMEPAGE="https://github.com/lfaoro/flares"
SRC_URI="https://github.com/lfaoro/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="test" # requires auth

src_compile() {
	GOFLAGS="-v -x -mod=vendor" \
		go build -o flaredns ./cmd/... || die "build failed"
}

src_test() {
	GOFLAGS="-v -x -mod=vendor" \
		go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin flaredns
}
