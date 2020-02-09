# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )
EGIT_REPO_URI="https://github.com/syrusakbary/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Python email validation library"
HOMEPAGE="https://github.com/syrusakbary/validate_email"
SRC_URI=""

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS=""
IUSE=""
