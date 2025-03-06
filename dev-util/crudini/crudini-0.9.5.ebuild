# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} python3_13t )

inherit distutils-r1 pypi

DESCRIPTION="A utility for manipulating ini files"
HOMEPAGE="https://github.com/pixelb/crudini"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="test" # no test files

RDEPEND="dev-python/iniparse"

distutils_enable_tests unittest
