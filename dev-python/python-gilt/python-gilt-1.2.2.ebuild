# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{8,10} )

inherit distutils-r1

DESCRIPTION="A GIT layering tool"
HOMEPAGE="https://github.com/metacloud/gilt"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # needs network

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/fasteners[${PYTHON_USEDEP}]
	dev-python/git-url-parse[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/pbr[${PYTHON_USEDEP}]
	test? ( dev-python/pytest-helpers-namespace[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
