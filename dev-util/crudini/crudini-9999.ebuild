# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} python3_13t )
EGIT_REPO_URI="https://github.com/pixelb/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="A utility for manipulating ini files"
HOMEPAGE="https://github.com/pixelb/crudini"

LICENSE="GPL-2"
SLOT="0"

RESTRICT="test" # no test files

RDEPEND="dev-python/iniparse[${PYTHON_USEDEP}]"

distutils_enable_tests unittest
