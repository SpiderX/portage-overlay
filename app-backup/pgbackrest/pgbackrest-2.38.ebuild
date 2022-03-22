# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Reliable PostgreSQL Backup & Restore"
HOMEPAGE="https://pgbackrest.org https://github.com/pgbackrest/pgbackrest"
SRC_URI="https://github.com/${PN}/${PN}/archive/release/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"

DEPEND="app-arch/lz4:=
	>=dev-db/postgresql-10:=[icu,ssl]
	dev-lang/perl:0=
	dev-libs/libxml2:2
	dev-libs/openssl:0=
	sys-libs/zlib:="
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/${PN}-release-${PV}/src"

src_install() {
	default
	keepdir /var/log/pgbackrest/
}
