# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Find diff lines that do not have test coverage"
HOMEPAGE="https://github.com/Bachmann1234/diff-cover"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/pluggy[${PYTHON_USEDEP}]
	dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/tomli[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/flake8[${PYTHON_USEDEP}]
		dev-python/pylint[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-{datadir,mock} )
distutils_enable_tests pytest
