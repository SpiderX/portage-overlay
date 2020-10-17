# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/cybertec-postgresql/${PN}.git"

inherit git-r3

DESCRIPTION="A PostgreSQL extension for automatic bloat cleanup"
HOMEPAGE="https://github.com/cybertec-postgresql/pg_squeeze"
SRC_URI=""

LICENSE="POSTGRESQL"
KEYWORDS=""
SLOT="0"
IUSE=""

DEPEND="dev-db/postgresql:*"
