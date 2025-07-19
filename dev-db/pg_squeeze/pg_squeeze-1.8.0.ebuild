# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="REL${PV//./_}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="A PostgreSQL extension for automatic bloat cleanup"
HOMEPAGE="https://github.com/cybertec-postgresql/pg_squeeze"
SRC_URI="https://github.com/cybertec-postgresql/${PN}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="POSTGRESQL"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-db/postgresql:*"
