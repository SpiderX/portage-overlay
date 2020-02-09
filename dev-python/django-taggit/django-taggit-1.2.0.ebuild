# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..7} )

inherit distutils-r1

DESCRIPTION="Django application for simple tagging"
HOMEPAGE="https://github.com/alex/django-taggit"
SRC_URI="https://github.com/alex/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( $(python_gen_impl_dep sqlite) )"

python_test() {
	PYTHONPATH=. django-admin.py test --settings=tests.settings \
		tests --verbosity 2 || die "tests failed with ${EPYTHON}"
}
