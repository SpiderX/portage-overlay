# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
EGIT_REPO_URI="https://github.com/amplify-education/${PN}.git"
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 git-r3

DESCRIPTION="A parser for HCL2 written in Python"
HOMEPAGE="https://github.com/amplify-education/python-hcl2"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/lark[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}] )"

distutils_enable_tests nose

python_prepare_all() {
	# Don't install tests
	sed -i "/find_packages/s/(/(exclude=['test','test.*']/" \
		setup.py || die "sed failed for setup.py"
	distutils-r1_python_prepare_all
}
