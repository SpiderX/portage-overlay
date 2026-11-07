# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit git-r3 go-module

DESCRIPTION="Tool for easy ClickHouse backup and restore"
HOMEPAGE="https://github.com/Altinity/clickhouse-backup"
EGIT_REPO_URI="https://github.com/Altinity/${PN}.git"

LICENSE="MIT"
SLOT="0"

BDEPEND=">=dev-lang/go-1.27.0"

DOCS=( {ChangeLog,Examples,Manual,ReadMe}.md )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	DATE="$(date +%F)"
	COMMIT="$(git rev-parse HEAD)"
	LDFLAGS="-X main.version=${PV} -X main.gitCommit=${COMMIT} -X \"main.buildDate=${DATE}\""
	ego build -tags netgo,osusergo -ldflags="${LDFLAGS}" -o clickhouse-backup ./cmd/clickhouse-backup
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
