# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Camel case JSON support for Django REST framework"
HOMEPAGE="https://github.com/vbabiy/djangorestframework-camel-case"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # no tests

RDEPEND="dev-python/djangorestframework[${PYTHON_USEDEP}]"

distutils_enable_tests unittest
