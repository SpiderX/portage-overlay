# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 edo pypi

DESCRIPTION="The set of adapter protocols and base functionality for dbt-core"
HOMEPAGE="https://github.com/dbt-labs/dbt-adapters"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/agate[${PYTHON_USEDEP}]
	dev-python/dbt-common[${PYTHON_USEDEP}]
	dev-python/dbt-protos[${PYTHON_USEDEP}]
	dev-python/mashumaro[${PYTHON_USEDEP}]
	dev-python/msgpack[${PYTHON_USEDEP}]
	dev-python/protobuf[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"

EPYTEST_XDIST=1
distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all

	# avoid file collision with dbt-core
	edo find "${ED}" -type d -path '*/include/__pycache__' -exec rm -rv {} +
	edo find "${ED}" -type f -path '*/include/__init__.py' -exec rm -rv {} +
}
