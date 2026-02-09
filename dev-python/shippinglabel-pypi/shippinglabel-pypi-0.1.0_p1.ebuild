# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

MY_PV="${PV/_p/.post}"

DESCRIPTION="Shippinglabel extension for interacting with PyPI"
HOMEPAGE="https://github.com/domdfcoding/shippinglabel-pypi"
SRC_URI="https://github.com/domdfcoding/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/apeye[${PYTHON_USEDEP}]
	dev-python/dist-meta[${PYTHON_USEDEP}]
	dev-python/domdf-python-tools[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pypi-json[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/shippinglabel[${PYTHON_USEDEP}]"
BDEPEND="dev-python/whey[${PYTHON_USEDEP}]
	test? ( dev-python/betamax[${PYTHON_USEDEP}]
		dev-python/coincidence[${PYTHON_USEDEP}]
		dev-python/consolekit[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}/${PN}"-0.1.0_p1-tests.patch )

EPYTEST_PLUGINS=( pytest-{datadir,regressions,rerunfailures,timeout} )

distutils_enable_tests pytest
