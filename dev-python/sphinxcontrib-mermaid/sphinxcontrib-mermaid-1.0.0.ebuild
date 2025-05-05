# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Mermaid diagrams in sphinx powered docs"
HOMEPAGE="https://github.com/mgaitan/sphinxcontrib-mermaid"
SRC_URI="https://github.com/mgaitan/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/myst-parser[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
