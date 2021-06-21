# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_8 )
EGIT_REPO_URI="https://github.com/celery/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Celery Periodic Tasks for Django"
HOMEPAGE="https://github.com/celery/django-celery-beat"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
RESTRICT="test"

RDEPEND="dev-python/celery[${PYTHON_USEDEP}]
	dev-python/django-timezone-field[${PYTHON_USEDEP}]
	dev-python/python-crontab[${PYTHON_USEDEP}]"
BDEPEND="test? ( $(python_gen_impl_dep sqlite) )"

distutils_enable_tests pytest

python_test() {
	"${PYTHON}" manage.py test t -v2 || die "tests failed with ${EPYTHON}"
}
