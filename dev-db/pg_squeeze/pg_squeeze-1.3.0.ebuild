# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV="REL${PV//./_}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="A PostgreSQL extension for automatic bloat cleanup"
HOMEPAGE="https://github.com/cybertec-postgresql/pg_squeeze"
SRC_URI="https://github.com/cybertec-postgresql/${PN}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="POSTGRESQL"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DEPEND="dev-db/postgresql:*"

S="${WORKDIR}/${MY_P}"
