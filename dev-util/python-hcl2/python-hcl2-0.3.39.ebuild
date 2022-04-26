# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

MY_PN="bc-${PN}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A parser for HCL2 written in Python"
HOMEPAGE="https://github.com/amplify-education/python-hcl2"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND=">=dev-python/lark-1.1.2[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests nose
