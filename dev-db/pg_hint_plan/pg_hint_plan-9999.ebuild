# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Manually force decisions in execution plans of PostgreSQL"
HOMEPAGE="https://github.com/ossc-db/pg_hint_plan"
EGIT_REPO_URI="https://github.com/ossc-db/${PN}.git"

LICENSE="BSD"
SLOT="9999"

RDEPEND="dev-db/postgresql:*"
