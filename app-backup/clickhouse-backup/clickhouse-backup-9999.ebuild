# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/AlexAkulov/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Tool for easy ClickHouse backup and restore"
HOMEPAGE="https://github.com/AlexAkulov/clickhouse-backup"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

DOCS=( {ChangeLog,Examples,ReadMe}.md )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	DATE="$(date +%F)"
	COMMIT="$(git rev-parse HEAD)"
	LDFLAGS="-X main.version=${PV} -X main.gitCommit=${COMMIT} -X \"main.buildDate=${DATE}\""
	go build -v -ldflags="${LDFLAGS}" -o clickhouse-backup ./cmd/clickhouse-backup \
		|| die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin clickhouse-backup

	insinto /etc/clickhouse-backup
	newins - config.yml.example < <("${ED}"/usr/bin/clickhouse-backup default-config )
}
