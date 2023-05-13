# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{8,10} )
EGIT_REPO_URI="https://github.com/joowani/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Command-line tool for looking up colors and palettes"
HOMEPAGE="https://github.com/joowani/colorpedia"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/fire[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
