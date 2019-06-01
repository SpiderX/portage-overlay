# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5..7} )
EGIT_REPO_URI="https://github.com/tmbo/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Python library to build pretty command line user prompts"
HOMEPAGE="https://github.com/tmbo/questionary"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND=">=dev-python/prompt_toolkit-2[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# Do not install tests
	sed -i '/packages=find_packages/s/s"/s", "tests.*"/' setup.py \
		|| die "sed for setup.py failed"
	distutils-r1_python_prepare_all
}

python_test() {
	py.test -v || die "tests failed with ${EPYTHON}"
}
