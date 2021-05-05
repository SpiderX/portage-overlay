# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Run periodic jobs in PostgreSQL"
HOMEPAGE="https://github.com/citusdata/pg_cron"
SRC_URI="https://github.com/citusdata/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="POSTGRESQL"
KEYWORDS="~amd64 ~x86"
SLOT="0"

DEPEND=">=dev-db/postgresql-9.5:="
