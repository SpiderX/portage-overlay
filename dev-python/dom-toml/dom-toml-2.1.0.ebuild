# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

MY_PN="${PN//-/_}"

DESCRIPTION="Dom's tools for Tom's Obvious, Minimal Language"
HOMEPAGE="https://github.com/domdfcoding/dom_toml"
SRC_URI="https://github.com/domdfcoding/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/domdf-python-tools[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/coincidence[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
