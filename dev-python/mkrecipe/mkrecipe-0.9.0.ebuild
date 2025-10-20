# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Recipes for building conda packages"
HOMEPAGE="https://github.com/repo-helper/mkrecipe"
SRC_URI="https://github.com/repo-helper/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	dev-python/consolekit[${PYTHON_USEDEP}]
	dev-python/dom-toml[${PYTHON_USEDEP}]
	dev-python/domdf-python-tools[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pyproject-parser[${PYTHON_USEDEP}]
	dev-python/shippinglabel[${PYTHON_USEDEP}]
	dev-python/shippinglabel-conda[${PYTHON_USEDEP}]
	dev-python/shippinglabel-pypi[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="dev-python/whey[${PYTHON_USEDEP}]
	test? ( dev-python/coincidence[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
