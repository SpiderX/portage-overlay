# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/lesovsky/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Command-line admin tool for observing and troubleshooting Postgres"
HOMEPAGE="https://github.com/lesovsky/pgcenter"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	go build -ldflags "-X github.com/lesovsky/pgcenter/cmd.gitTag=${PV}
		-X github.com/lesovsky/pgcenter/cmd.gitCommit=${PV}
		-X github.com/lesovsky/pgcenter/cmd.gitBranch=${PV}" \
		|| die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin pgcenter
}
