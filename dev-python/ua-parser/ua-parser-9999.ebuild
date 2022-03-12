# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/selwin/python-user-agents.git"

inherit distutils-r1 git-r3

DESCRIPTION="A python implementation of the UA Parser"
HOMEPAGE="https://github.com/ua-parser/uap-python"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

BDEPEND="test? ( dev-python/pyyaml[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest

python_install_all() {
	distutils-r1_python_install_all
	find "${D}" -name '*test.*' -delete || die "test removing failed"
}
