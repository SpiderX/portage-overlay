# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/peak/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Parallel S3 and local filesystem execution tool"
HOMEPAGE="https://github.com/peak/s5cmd"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

DOCS=( {CHANGELOG,README}.md )

src_unpack() {
	git-r3_src_unpack
}

src_compile() {
	LDFLAGS="-X=github.com/peak/s5cmd/version.Version=${PV}
		-X=github.com/peak/s5cmd/version.GitCommit=${COMMIT}"

	GOFLAGS="-v -x -mod=vendor" \
		go build -ldflags "${LDFLAGS}" || die "build failed"
}

src_test() {
	GOFLAGS="-v -x -mod=vendor" \
		go test -work || die "test failed"
}

src_install() {
	einstalldocs
	dobin s5cmd
}
