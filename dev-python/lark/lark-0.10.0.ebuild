# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="A modern general-purpose parsing library for Python"
HOMEPAGE="https://github.com/lark-parser/lark"
SRC_URI="https://github.com/lark-parser/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no files

BDEPEND="test? ( dev-python/js2py[${PYTHON_USEDEP}]
		dev-python/regex[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest

python_prepare_all() {
	# Fix QA
	sed -i '/description/s/-/_/' setup.cfg || die "sed failed"
	distutils-r1_python_prepare_all
}
