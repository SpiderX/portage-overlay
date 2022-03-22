# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"

inherit git-r3

DESCRIPTION="Reliable PostgreSQL Backup & Restore"
HOMEPAGE="https://pgbackrest.org https://github.com/pgbackrest/pgbackrest"
SRC_URI=""

LICENSE="MIT"
KEYWORDS=""
SLOT="0"

DEPEND="app-arch/lz4:=
	>=dev-db/postgresql-10:=[icu,ssl]
	dev-lang/perl:0=
	dev-libs/libxml2:2
	dev-libs/openssl:0=
	sys-libs/zlib:="
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_install() {
	default
	keepdir /var/log/pgbackrest/
}
