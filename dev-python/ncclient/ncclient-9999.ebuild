# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )
EGIT_REPO_URI="https://github.com/ncclient/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Python library for NETCONF clients"
HOMEPAGE="https://github.com/ncclient/ncclient"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/paramiko[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}] )"

distutils_enable_tests nose

python_prepare_all() {
	# Do not install tests
	sed -i "/find_packages/s/'.'/exclude=['test','test.*']/" setup.py \
		|| die "sed for setup.py failed"

	distutils-r1_python_prepare_all
}
