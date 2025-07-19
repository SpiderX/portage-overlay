# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="REL15_${PV//./_}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Manually force decisions in execution plans of PostgreSQL"
HOMEPAGE="https://github.com/ossc-db/pg_hint_plan"
SRC_URI="https://github.com/ossc-db/${PN}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="15"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-db/postgresql:15"
