# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo git-r3 go-module

DESCRIPTION="TUI for reviewing diffs, files, and documents with inline annotations"
HOMEPAGE="https://github.com/umputun/revdiff"
EGIT_REPO_URI="https://github.com/umputun/${PN}.git"

LICENSE="MIT"
SLOT="0"

BDEPEND=">=dev-lang/go-1.26.1:="

DOCS=( {CHANGELOG,README}.md )

src_unpack() {
	git-r3_src_unpack
}

src_compile() {
	COMMIT="$(git rev-parse --short=7 HEAD)"
	DATE="$(date -u '+%Y%m%dT%H%M%S')"
	LDFLAGS="-w -X \"main.revision=${PV} (master-${COMMIT}-${DATE})\""

	GOFLAGS="-v -x -mod=vendor" \
		ego build -ldflags "${LDFLAGS}" -o revdiff ./app
}

src_test() {
	edo git init
	edo git config user.email "you@example.com"
	edo git config user.name "Your Name"

	GOFLAGS="-v -x -mod=vendor" ego test -work ./...
}

src_install() {
	einstalldocs
	dobin revdiff
}
