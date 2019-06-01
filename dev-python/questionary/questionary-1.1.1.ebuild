# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5..7} )

inherit distutils-r1

DESCRIPTION="Python library to build pretty command line user prompts"
HOMEPAGE="https://github.com/tmbo/questionary"
SRC_URI="https://github.com/tmbo/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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

#python_install_all() {
#	distutils-r1_python_install_all
#	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
#}
