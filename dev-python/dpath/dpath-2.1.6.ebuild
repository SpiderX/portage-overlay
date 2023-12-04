# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11} )

inherit distutils-r1 pypi

DESCRIPTION="A python module that will check for package updates"
HOMEPAGE="https://github.com/dpath-maintainers/dpath-python"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="test? ( dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/nose2[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest
