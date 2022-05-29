# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

SLOT="13"
MY_PV="REL${SLOT}_${PV//./_}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Manually force decisions in execution plans of PostgreSQL"
HOMEPAGE="https://github.com/ossc-db/pg_hint_plan"
SRC_URI="https://github.com/ossc-db/${PN}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-db/postgresql:*"

S="${WORKDIR}/${MY_P}"
