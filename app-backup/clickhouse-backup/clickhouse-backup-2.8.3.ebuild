# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit go-module

COMMIT="246a8b"

DESCRIPTION="Tool for easy ClickHouse backup and restore"
HOMEPAGE="https://github.com/Altinity/clickhouse-backup"
SRC_URI="https://github.com/Altinity/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND=">=dev-lang/go-1.27.0"

DOCS=( {ChangeLog,Examples,Manual,ReadMe}.md )

src_compile() {
	DATE="$(date +%F)"
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
