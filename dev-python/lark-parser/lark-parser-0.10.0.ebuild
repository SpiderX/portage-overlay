# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

MY_PN="lark"
MY_P="lark-${PV}"

DESCRIPTION="A modern general-purpose parsing library for Python"
HOMEPAGE="https://github.com/lark-parser/lark"
SRC_URI="https://github.com/lark-parser/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no files

BDEPEND="test? ( dev-python/js2py[${PYTHON_USEDEP}]
		dev-python/regex[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests unittest
