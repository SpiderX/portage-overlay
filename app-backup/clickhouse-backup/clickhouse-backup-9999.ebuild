# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/Altinity/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Tool for easy ClickHouse backup and restore"
HOMEPAGE="https://github.com/Altinity/clickhouse-backup"

LICENSE="MIT"
SLOT="0"

DOCS=( {ChangeLog,Examples,ReadMe}.md )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	DATE="$(date +%F)"
	COMMIT="$(git rev-parse HEAD)"
	LDFLAGS="-X main.version=${PV} -X main.gitCommit=${COMMIT} -X \"main.buildDate=${DATE}\""
	ego build -v -ldflags="${LDFLAGS}" -o clickhouse-backup ./cmd/clickhouse-backup
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin clickhouse-backup

	insinto /etc/clickhouse-backup
	newins - config.yml.example < <("${ED}"/usr/bin/clickhouse-backup default-config \
		|| die "default-config failed" )
}
