# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 git-r3

DESCRIPTION="The set of reusable tests and test fixtures for dbt"
HOMEPAGE="https://github.com/dbt-labs/dbt-adapters"
EGIT_REPO_URI="https://github.com/dbt-labs/${PN}.git"
S="${WORKDIR}/${P}/${PN}"

LICENSE="Apache-2.0"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-python/dbt-adapters[${PYTHON_USEDEP}]
	dev-python/dbt-common[${PYTHON_USEDEP}]
	dev-python/freezegun[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-util/dbt-core[${PYTHON_USEDEP}]"
