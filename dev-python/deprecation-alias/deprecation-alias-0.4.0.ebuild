# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="A wrapper around 'deprecation' providing support for deprecated aliases"
HOMEPAGE="https://github.com/domdfcoding/deprecation-alias"
SRC_URI="https://github.com/domdfcoding/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/deprecation[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]"
BDEPEND="dev-python/hatch-requirements-txt[${PYTHON_USEDEP}]
	test? ( dev-python/coincidence[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-timeout )
distutils_enable_tests pytest
