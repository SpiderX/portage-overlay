# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="PostgreSQL extension that requires criteria for UPDATE and DELETE"
HOMEPAGE="https://github.com/eradman/pg-safeupdate"
SRC_URI="https://github.com/eradman/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # tests needs installed extension

DEPEND="dev-db/postgresql:*"

src_compile() {
	emake USE_PGXS=1
}
