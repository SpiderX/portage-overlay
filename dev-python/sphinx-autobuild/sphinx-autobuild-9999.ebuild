# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )
EGIT_REPO_URI="https://github.com/GaretJax/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Mermaid diagrams in sphinx powered docs"
HOMEPAGE="https://github.com/GaretJax/sphinx-autobuild"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="dev-python/argh[${PYTHON_USEDEP}]
	dev-python/livereload[${PYTHON_USEDEP}]
	dev-python/pathtools[${PYTHON_USEDEP}]
	dev-python/port-for[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]
	www-servers/tornado[${PYTHON_USEDEP}]
	dev-python/watchdog[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}]
		virtual/python-unittest-mock[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# Relax requirement
	sed -i '/port_for/s|==|>=|' requirements.txt \
		|| die "sed failed for requirements.txt"
	# Remove settings for pytest
	rm pytest.ini || die "rm pytest.ini failed"

	distutils-r1_python_prepare_all
}

python_test() {
	py.test -v || die "tests failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "test" -exec rm -rv {} + || die "tests removing failed"
}
