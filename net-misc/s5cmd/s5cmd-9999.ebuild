# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="Parallel S3 and local filesystem execution tool"
HOMEPAGE="https://github.com/peak/s5cmd"
EGIT_REPO_URI="https://github.com/peak/${PN}.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # fails

DOCS=( {CHANGELOG,README}.md )

src_unpack() {
	git-r3_src_unpack
}

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
