# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Reliable PostgreSQL Backup & Restore"
HOMEPAGE="https://pgbackrest.org https://github.com/pgbackrest/pgbackrest"
SRC_URI="https://github.com/${PN}/${PN}/archive/release/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="libressl"

DEPEND="app-arch/lz4:=
	dev-db/postgresql:=[icu,ssl]
	dev-lang/perl:0=
	dev-libs/libxml2:2
	sys-libs/zlib:=
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/${PN}-release-${PV}/src"
