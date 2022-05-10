# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/benbjohnson/${PN}.git"

inherit go-module git-r3 systemd

DESCRIPTION="Streaming replication for SQLite"
HOMEPAGE="https://github.com/benbjohnson/litestream"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-s -w -X main.Version=${PV}"
	go build -v -ldflags "${LDFLAGS}" -o litestream ./cmd/litestream \
		|| die "build failed"
}

src_test() {
	go test || die "test failed"
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
