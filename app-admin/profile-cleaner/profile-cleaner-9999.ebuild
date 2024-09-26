# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/graysky2/${PN}.git"

inherit git-r3

DESCRIPTION="Vacuum and reindex browser sqlite databases"
HOMEPAGE="https://github.com/graysky2/profile-cleaner"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-alternatives/bc
	sys-process/parallel
	dev-db/sqlite:3"
