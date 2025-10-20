# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Example pyproject.toml configs for testing"
HOMEPAGE="https://github.com/repo-helper/pyproject-examples"
SRC_URI="https://github.com/repo-helper/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # no tests

RDEPEND="dev-python/coincidence[${PYTHON_USEDEP}]
	dev-python/dom-toml[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]"
BDEPEND="dev-python/whey[${PYTHON_USEDEP}]"
