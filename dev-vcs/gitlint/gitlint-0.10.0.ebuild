# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )

inherit distutils-r1

DESCRIPTION="Git commit message linter"
HOMEPAGE="https://github.com/jorisroovers/gitlint"
SRC_URI="https://github.com/jorisroovers/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/arrow[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/backports-functools-lru-cache[${PYTHON_USEDEP}]' -2 )"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}]
		$(python_gen_cond_dep 'dev-python/unittest2[${PYTHON_USEDEP}]' -2 )
		virtual/python-unittest-mock[${PYTHON_USEDEP}] )"

# https://github.com/jorisroovers/gitlint/issues/78
PATCHES=( "${FILESDIR}"/"${P}"-test.patch )

python_prepare_all() {
	# Relax requirements
	sed -i  -e '/arrow==0.10.0/s/==/>=/' \
		-e '/Click==6.6/s/==/>=/' \
		-e '/sh==1.11/s/==/>=/' setup.py || die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}

python_test() {
	cd gitlint || die "change dir failed"
	py.test -v || die "tests failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
	find "${ED}" -type d -name "qa" -exec rm -rv {} + || die "integration tests removing failed"
}
