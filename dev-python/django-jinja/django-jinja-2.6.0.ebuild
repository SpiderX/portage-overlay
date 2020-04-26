# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )

inherit distutils-r1

DESCRIPTION="Jinja2 templating language integrated in Django"
HOMEPAGE="https://github.com/niwinz/django-jinja"
SRC_URI="https://github.com/niwinz/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

# https://github.com/niwinz/django-jinja/issues/181
PATCHES=( "${FILESDIR}"/"${P}"-test.patch )

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( $(python_gen_impl_dep sqlite)
		dev-python/django-pipeline[${PYTHON_USEDEP}] )"

python_test() {
	"${PYTHON}" testing/runtests.py || die "tests failed with ${EPYTHON}"
}
