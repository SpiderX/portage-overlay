# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Extensions to the Dulwich Git library"
HOMEPAGE="https://github.com/repo-helper/southwark"
SRC_URI="https://github.com/repo-helper/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	dev-python/consolekit[${PYTHON_USEDEP}]
	dev-python/domdf-python-tools[${PYTHON_USEDEP}]
	dev-python/dulwich[${PYTHON_USEDEP}]
	dev-python/filelock[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="dev-python/whey[${PYTHON_USEDEP}]
	test? ( dev-python/apeye[${PYTHON_USEDEP}]
		dev-python/coincidence[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-{datadir,git,regressions,timeout} )
distutils_enable_tests pytest
