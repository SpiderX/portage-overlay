# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="A PostgreSQL extension for automatic bloat cleanup"
HOMEPAGE="https://github.com/cybertec-postgresql/pg_squeeze"
EGIT_REPO_URI="https://github.com/cybertec-postgresql/${PN}.git"

LICENSE="POSTGRESQL"
SLOT="0"

RDEPEND="dev-db/postgresql:*"
