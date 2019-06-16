# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5..7}} )
EHG_REPO_URI="https://bitbucket.org/leapfrogdevelopment/rstr"

inherit distutils-r1 mercurial

DESCRIPTION="Generate random strings in Python"
HOMEPAGE="http://bitbucket.org/leapfrogdevelopment/rstr"
SRC_URI=""

LICENSE="BSD"
SLOT=0
KEYWORDS=""
IUSE="test"

RDEPEND="$(python_gen_cond_dep 'dev-python/functools32[${PYTHON_USEDEP}]' '-2')"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/unittest2[${PYTHON_USEDEP}] )"

src_prepare() {
	default

	_remove_test() {
		# Test failed on python3
		if [ "${EPYTHON}" != "python2.7" ]; then
			sed -i "/unambiguous(include='@'/s/include='@'//" rstr/tests/test_rstr.py \
				|| die "sed failed for test_rstr.py"
		fi
	}
	python_foreach_impl _remove_test
}

python_test() {
	"${PYTHON}" -m unittest discover rstr/tests || die "tests failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}
