# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/citusdata/${PN}.git"

inherit git-r3

DESCRIPTION="Run periodic jobs in PostgreSQL"
HOMEPAGE="https://github.com/citusdata/pg_cron"
SRC_URI=""

LICENSE="POSTGRESQL"
KEYWORDS=""
SLOT="0"

DEPEND=">=dev-db/postgresql-9.5:="
