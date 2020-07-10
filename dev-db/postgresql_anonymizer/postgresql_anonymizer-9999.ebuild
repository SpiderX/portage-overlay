# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://gitlab.com/dalibo/${PN}.git"

inherit git-r3

DESCRIPTION="Anonymization & Data Masking for PostgreSQL"
HOMEPAGE="https://gitlab.com/dalibo/postgresql_anonymizer"
SRC_URI=""

LICENSE="POSTGRESQL"
KEYWORDS=""
SLOT="0"
IUSE=""

DEPEND=">=dev-db/postgresql-9.5:="

DOCS=( {CHANGELOG,NEWS,README}.md )
