# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/ossc-db/${PN}.git"

inherit git-r3

DESCRIPTION="Manually force decisions in execution plans of PostgreSQL"
HOMEPAGE="https://github.com/ossc-db/pg_hint_plan"
SRC_URI=""

LICENSE="BSD"
KEYWORDS=""
SLOT="9999"

DEPEND="dev-db/postgresql:*"
