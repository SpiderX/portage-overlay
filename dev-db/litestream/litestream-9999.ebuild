# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module git-r3 systemd

DESCRIPTION="Streaming replication for SQLite"
HOMEPAGE="https://github.com/benbjohnson/litestream"
EGIT_REPO_URI="https://github.com/benbjohnson/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-X main.Version=${PV}"
	ego build -v -ldflags "${LDFLAGS}" -o litestream ./cmd/litestream
}

src_test() {
	ego test
}

src_install() {
	einstalldocs
	dobin litestream
	insinto /etc
	doins etc/litestream.yml

	newinitd "${FILESDIR}"/litestream.initd litestream
	newconfd "${FILESDIR}"/litestream.confd litestream
	systemd_dounit etc/litestream.service
}
