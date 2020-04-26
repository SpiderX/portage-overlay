# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )

inherit distutils-r1

DESCRIPTION="A reusable Django model field for storing ad-hoc JSON data"
HOMEPAGE="https://github.com/rpkilby/jsonfield"
SRC_URI="https://github.com/rpkilby/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( $(python_gen_impl_dep sqlite) )"

python_test() {
	"${PYTHON}" manage.py test -v2 || die "tests failed with ${EPYTHON}"
}
