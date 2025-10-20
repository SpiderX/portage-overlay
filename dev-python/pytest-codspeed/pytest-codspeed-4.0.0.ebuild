# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 edo pypi

DESCRIPTION="Pytest plugin to create CodSpeed benchmarks"
HOMEPAGE="https://github.com/CodSpeedHQ/pytest-codspeed"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/cffi:=[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

export PYTEST_CODSPEED_FORCE_EXTENSION_BUILD=1

src_prepare() {
	default

	if use test ; then
		edo cp "${FILESDIR}"/conftest.py tests
		edo mkdir tests/examples
		edo cp "${FILESDIR}"/test_addition_fixture.py tests/examples
	fi
}
