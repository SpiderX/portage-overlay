# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Standard library mailcap redistribution"
HOMEPAGE="https://github.com/youknowone/python-deadlib"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no files

distutils_enable_tests pytest
