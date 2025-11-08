# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="The kitchen sink of Python functional utility libraries"
HOMEPAGE="https://github.com/dgilland/pydash"
SRC_URI="https://github.com/dgilland/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/typing-extensions[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

# requires pytest-mypy-testing
EPYTEST_IGNORE=( tests/pytest_mypy_testing )

python_prepare_all() {
	# remove pytest plugin usage
	sed -i '/addopts/,+9d' pyproject.toml \
		|| die "sed failed for pyproject.toml"

	distutils-r1_python_prepare_all
}
