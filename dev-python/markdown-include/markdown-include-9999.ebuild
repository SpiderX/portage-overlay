# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/cmacmackin/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Provides the inclusion of the contents of other Markdown documents"
HOMEPAGE="https://github.com/cmacmackin/markdown-include"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
RESTRICT="test" # no tests

RDEPEND="dev-python/markdown[${PYTHON_USEDEP}]"
