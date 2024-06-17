# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="A declarative object transformer for conglomerating nested data"
HOMEPAGE="https://github.com/mahmoud/glom"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/boltons[${PYTHON_USEDEP}]
	dev-python/face[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
