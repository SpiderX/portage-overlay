# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..7} )

MY_PV="$(ver_cut 1-2)"
MY_P="${PN}-${MY_PV}"

inherit distutils-r1

DESCRIPTION="A script tag with additional attributes for django.forms.Media"
HOMEPAGE="https://github.com/matthiask/django-js-asset"
SRC_URI="https://github.com/matthiask/${PN}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
BDEPEND="test? ( $(python_gen_impl_dep sqlite) ) "

S="${WORKDIR}/${MY_P}"

python_test() {
	./tests/manage.py test testapp --verbosity 2 || die "tests failed with ${EPYTHON}"
}
