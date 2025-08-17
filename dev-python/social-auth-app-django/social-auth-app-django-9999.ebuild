# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11,12} )

inherit distutils-r1 git-r3

DESCRIPTION="Python Social Auth - Application - Django"
HOMEPAGE="https://github.com/python-social-auth/social-app-django"
EGIT_REPO_URI="https://github.com/python-social-auth/social-app-django.git"

LICENSE="BSD"
SLOT="0"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/social-auth-core[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_test() {
	"${PYTHON}" manage.py test -v2 || die "tests failed with ${EPYTHON}"
}
