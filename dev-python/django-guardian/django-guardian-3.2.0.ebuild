# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
PYTHON_REQ_USE="sqlite(+)"

inherit distutils-r1

DESCRIPTION="Implementation of per object permissions for Django"
HOMEPAGE="https://github.com/django-guardian/django-guardian"
SRC_URI="https://github.com/django-guardian/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/django-environ[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-django )
distutils_enable_tests pytest

python_test() {
	"${PYTHON}" manage.py test guardian -v2 || die "tests failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "testapp" -exec rm -rv {} + || die "tests removing failed"
}
