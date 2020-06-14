# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )

inherit distutils-r1

DESCRIPTION="OAuth2 Provider for Django"
HOMEPAGE="https://github.com/jazzband/django-oauth-toolkit"
SRC_URI="https://github.com/jazzband/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-python/django-2[${PYTHON_USEDEP}]
	dev-python/oauthlib[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
BDEPEND="test? ( $(python_gen_impl_dep sqlite)
		dev-python/django-rest-framework[${PYTHON_USEDEP}]
		dev-python/pytest-django[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}] ) "

python_prepare_all() {
	# Don't install tests
	sed -i '/exclude/s/ts/ts,tests.*/' setup.cfg \
		|| die "sed failed for setup.cfg"

	distutils-r1_python_prepare_all
}

python_test() {
	DJANGO_SETTINGS_MODULE=tests.settings PYTHONPATH=. \
		py.test -v || die "tests failed with ${EPYTHON}"
}
