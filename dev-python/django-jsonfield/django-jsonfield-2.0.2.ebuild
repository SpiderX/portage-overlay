# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )

inherit distutils-r1

DESCRIPTION="A Django field to store validated JSON in your model"
HOMEPAGE="https://github.com/dmkoch/django-jsonfield"
SRC_URI="https://github.com/dmkoch/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( $(python_gen_impl_dep sqlite) )"

python_test() {
	# no verbose in tests
	"${PYTHON}" setup.py test || die "tests failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${D}" -name '*tests.*' -delete || die "test removing failed"
}
