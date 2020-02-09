# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..7} )
EGIT_REPO_URI="https://github.com/celery/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Celery Periodic Tasks for Django"
HOMEPAGE="https://github.com/celery/django-celery-beat"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="dev-python/celery[${PYTHON_USEDEP}]
	dev-python/django-timezone-field[${PYTHON_USEDEP}]
	dev-python/python-crontab[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( $(python_gen_impl_dep sqlite)
		dev-python/pytest[${PYTHON_USEDEP}] )"

python_test() {
	"${PYTHON}" manage.py test t -v2 || die "tests failed with ${EPYTHON}"
}
