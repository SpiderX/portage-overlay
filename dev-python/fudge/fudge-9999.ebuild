# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{6..7}} )
EGIT_REPO_URI="https://github.com/fudge-py/fudge.git"

inherit distutils-r1 git-r3

DESCRIPTION="Replace real objects with fakes (mocks, stubs, etc) while testing"
HOMEPAGE="http://farmdev.com/projects/fudge"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="doc test"
RESTRICT="!test? ( test )"

RDEPEND=""
DEPEND="doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	nosetests -w "${BUILD_DIR}"/lib \
		|| die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}
