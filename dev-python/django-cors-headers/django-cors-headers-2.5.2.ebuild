# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5..7}} )

inherit distutils-r1

DESCRIPTION="Django application for Cross-Origin Resource Sharing (CORS)"
HOMEPAGE="https://github.com/ottoyiu/django-cors-headers"
SRC_URI="https://github.com/ottoyiu/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( $(python_gen_impl_dep sqlite)
		dev-python/pytest-django[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# Remove coverage from tests
	sed -i '/cov/d' pytest.ini || die "sed failed for pytest.ini"
	distutils-r1_python_prepare_all
}

python_test() {
	./runtests.py -v || die "tests failed with ${EPYTHON}"
}
