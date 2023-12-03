# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
EGIT_REPO_URI="https://github.com/bridgecrewio/${PN}.git"
PYTHON_COMPAT=( python3_{9..12} )

inherit distutils-r1 git-r3

DESCRIPTION="A fork of parser for HCL2 written in Python"
HOMEPAGE="https://github.com/bridgecrewio/python-hcl2"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/lark[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	# Don't install tests
	sed -i "/find_packages/s/(/(exclude=['test','test.*']/" \
		setup.py || die "sed failed for setup.py"
	distutils-r1_python_prepare_all
}
