# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Run periodic jobs in PostgreSQL"
HOMEPAGE="https://github.com/citusdata/pg_cron"
EGIT_REPO_URI="https://github.com/citusdata/${PN}.git"

LICENSE="POSTGRESQL"
SLOT="0"

RDEPEND="dev-db/postgresql:="
