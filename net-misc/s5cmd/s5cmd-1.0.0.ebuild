# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="Parallel S3 and local filesystem execution tool"
HOMEPAGE="https://github.com/peak/s5cmd"
SRC_URI="https://github.com/peak/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DOCS=( {CHANGELOG,README}.md )

src_compile() {
	GOFLAGS="-v -x -mod=vendor" \
		go build || die "build failed"
}

src_test() {
	GOFLAGS="-v -x -mod=vendor" \
		go test -work || die "test failed"
}

src_install() {
	einstalldocs
	dobin s5cmd
}
