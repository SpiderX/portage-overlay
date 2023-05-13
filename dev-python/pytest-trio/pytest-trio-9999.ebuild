# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,10} )
EGIT_REPO_URI="https://github.com/python-trio/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Python library for async concurrency and I/O"
HOMEPAGE="https://github.com/python-trio/pytest-trio"
SRC_URI=""

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS=""
RESTRICT="test" # not ready

DEPEND="dev-python/async_generator[${PYTHON_USEDEP}]
	dev-python/outcome[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/trio[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND="test? ( dev-python/hypothesis[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	# Disable coverage for pytest
	sed -i '/addopts/s/ --cov//' pytest.ini || die "sed failed for pytest.ini"

	distutils-r1_python_prepare_all
}
