# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Postgres historic performance reports"
HOMEPAGE="https://github.com/zubkov-andrei/pg_profile"
SRC_URI="https://github.com/zubkov-andrei/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="POSTGRESQL"
KEYWORDS="~amd64 ~x86"
SLOT="0"

DEPEND="dev-db/postgresql:*"

src_compile() {
	emake USE_PGXS=1
}

src_install() {
	emake USE_PGXS=1 DESTDIR="${D}" install
}
