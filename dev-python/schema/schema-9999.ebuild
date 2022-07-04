# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/keleshev/${PN}.git"
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1 git-r3

DESCRIPTION="Simple data validation library"
HOMEPAGE="https://github.com/keleshev/schema"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

BDEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
