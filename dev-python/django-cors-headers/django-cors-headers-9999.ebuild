# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..7} )
EGIT_REPO_URI="https://github.com/ottoyiu/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Django application for Cross-Origin Resource Sharing (CORS)"
HOMEPAGE="https://github.com/ottoyiu/django-cors-headers"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
BDEPEND="test? ( $(python_gen_impl_dep sqlite)
		dev-python/pytest-django[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# Remove coverage from tests
	sed -i '/cov/d' pytest.ini || die "sed failed for pytest.ini"

	distutils-r1_python_prepare_all
}

python_test() {
	./runtests.py -v || die "tests failed with ${EPYTHON}"
}
