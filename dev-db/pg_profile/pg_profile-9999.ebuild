# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/zubkov-andrei/${PN}.git"

inherit git-r3

DESCRIPTION="Postgres historic performance reports"
HOMEPAGE="https://github.com/zubkov-andrei/pg_profile"
SRC_URI=""

LICENSE="LGPL-3"
KEYWORDS=""
SLOT="0"
IUSE=""

DEPEND="dev-db/postgresql:*"
