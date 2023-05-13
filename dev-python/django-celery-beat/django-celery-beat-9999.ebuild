# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8,10} )
EGIT_REPO_URI="https://github.com/celery/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Celery Periodic Tasks for Django"
HOMEPAGE="https://github.com/celery/django-celery-beat"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/celery[${PYTHON_USEDEP}]
	dev-python/django-timezone-field[${PYTHON_USEDEP}]
	dev-python/python-crontab[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/case[${PYTHON_USEDEP}]
		dev-python/pytest-timeout[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
		sci-astronomy/pyephem[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	t/unit/test_models.py::CrontabScheduleTestCase::test_default_timezone_with_settings_config
	# Failed: Timeout >5.0s
	t/unit/test_schedulers.py::test_modeladmin_PeriodicTaskAdmin::test_run_task
	t/unit/test_schedulers.py::test_modeladmin_PeriodicTaskAdmin::test_run_tasks
)

python_prepare_all() {
	# Fix test
	sed -i "/TimeZoneField/s|.default_choices\[0\]\[0\].zone|(default='UTC')|" \
		t/unit/test_models.py

	distutils-r1_python_prepare_all
}
