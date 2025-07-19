# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="Command-line admin tool for observing and troubleshooting Postgres"
HOMEPAGE="https://github.com/lesovsky/pgcenter"
EGIT_REPO_URI="https://github.com/lesovsky/${PN}.git"

LICENSE="BSD"
SLOT="0"
RESTRICT="test" # need postgres

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-X github.com/lesovsky/pgcenter/cmd.gitTag=${PV}
		-X github.com/lesovsky/pgcenter/cmd.gitCommit=${PV}
		-X github.com/lesovsky/pgcenter/cmd.gitBranch=${PV}"
	ego build -ldflags "${LDFLAGS}" -o pgcenter ./cmd
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin pgcenter
}
