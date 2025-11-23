# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

COMMIT="991c9fb"

DESCRIPTION="Parallel S3 and local filesystem execution tool"
HOMEPAGE="https://github.com/peak/s5cmd"
SRC_URI="https://github.com/peak/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # fails

DOCS=( {CHANGELOG,README}.md )

src_compile() {
	LDFLAGS="-X=github.com/peak/s5cmd/v2/version.Version=${PV}
		-X=github.com/peak/s5cmd/v2/version.GitCommit=${COMMIT}"

	ego build -ldflags "${LDFLAGS}"
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin s5cmd
}
