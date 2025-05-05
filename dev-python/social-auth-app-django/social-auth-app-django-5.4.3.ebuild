# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python Social Auth - Application - Django"
HOMEPAGE="https://github.com/python-social-auth/social-app-django"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/social-auth-core[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_test() {
	mkdir "${S}"/tests/templates || die "mkdir failed"
	echo -e "test" > "${S}"/tests/templates/test.html || die "echo failed"
	"${PYTHON}" manage.py test -v2 || die "tests failed with ${EPYTHON}"
}
