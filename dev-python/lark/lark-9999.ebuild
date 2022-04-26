# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
EGIT_REPO_URI="https://github.com/lark-parser/${PN}.git"
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 git-r3

DESCRIPTION="A modern general-purpose parsing library for Python"
HOMEPAGE="https://github.com/lark-parser/lark"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

BDEPEND="test? ( dev-python/atomicwrites[${PYTHON_USEDEP}]
		dev-python/js2py[${PYTHON_USEDEP}]
		dev-python/regex[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest

python_test() {
	"${EPYTHON}" -m tests -v || die "tests failed with ${EPYTHON}"
}
