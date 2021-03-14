# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="Recursive Serialization for Django REST framework"
HOMEPAGE="https://github.com/heywbj/django-rest-framework-recursive"
SRC_URI="https://github.com/heywbj/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # fails

RDEPEND="dev-python/django-rest-framework[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( $(python_gen_impl_dep sqlite) )"

# remove incorrectly defined test
PATCHES=( "${FILESDIR}/${P}"-test-model.patch
	"${FILESDIR}/${PN}"-0.1.2-test.patch )

distutils_enable_tests pytest

python_test() {
	./runtests.py -v || die "tests failed with ${EPYTHON}"
}
