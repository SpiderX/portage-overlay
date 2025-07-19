# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="CLI for SQL Server and Azure SQL"
HOMEPAGE="https://github.com/microsoft/go-sqlcmd"
EGIT_REPO_URI="https://github.com/microsoft/${PN}.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # needs mssql

src_compile() {
	LDFLAGS="-w -X main.version=${PV}"

	ego build -ldflags "${LDFLAGS}" -o go-sqlcmd ./cmd/modern
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin go-sqlcmd
}
