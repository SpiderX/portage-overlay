# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="A library for diffs of python data structures"
HOMEPAGE="https://sourceforge.net/projects/datadiff/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

BDEPEND="test? ( dev-python/six[${PYTHON_USEDEP}] )"

distutils_enable_tests nose
