# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..7} )

inherit distutils-r1

DESCRIPTION="Recursive Serialization for Django REST framework"
HOMEPAGE="https://github.com/heywbj/django-rest-framework-recursive"
SRC_URI="https://github.com/heywbj/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

# remove incorrectly defined test
PATCHES=( "${FILESDIR}/${P}"-test.patch )

RDEPEND="dev-python/django-rest-framework[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( $(python_gen_impl_dep sqlite)
		dev-python/pytest[${PYTHON_USEDEP}] )"

python_test() {
	./runtests.py -v || die "tests failed with ${EPYTHON}"
}
