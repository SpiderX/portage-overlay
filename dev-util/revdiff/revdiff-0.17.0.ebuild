# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo go-module

COMMIT="71e9e4d"

DESCRIPTION="TUI for reviewing diffs, files, and documents with inline annotations"
HOMEPAGE="https://github.com/umputun/revdiff"
SRC_URI="https://github.com/umputun/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND=">=dev-lang/go-1.26.1:=
	test? ( dev-vcs/git )"

DOCS=( {CHANGELOG,README}.md )

src_compile() {
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
