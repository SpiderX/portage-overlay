# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Celery Periodic Tasks for Django"
HOMEPAGE="https://github.com/celery/django-celery-beat"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/celery[${PYTHON_USEDEP}]
	dev-python/cron-descriptor[${PYTHON_USEDEP}]
	dev-python/django[${PYTHON_USEDEP}]
	dev-python/django-timezone-field[${PYTHON_USEDEP}]
	dev-python/python-crontab[${PYTHON_USEDEP}]
	dev-python/tzdata[${PYTHON_USEDEP}]"
BDEPEND="test? ( sci-astronomy/pyephem[${PYTHON_USEDEP}] )"

EPYTEST_TIMEOUT=1
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# Failed: Timeout >1.0s
	t/unit/test_schedulers.py::test_DatabaseScheduler::test_sync_not_saves_last_run_at_while_schedule_changed
	t/unit/test_schedulers.py::test_DatabaseScheduler::test_heap_always_return_the_first_item
	t/unit/test_schedulers.py::test_DatabaseScheduler::test_starttime_trigger
	t/unit/test_schedulers.py::test_DatabaseScheduler::test_crontab_with_start_time_tick
	# kombu.exceptions.OperationalError: [Errno 111] Connection refused
	t/unit/test_schedulers.py::test_modeladmin_PeriodicTaskAdmin::test_run_task
	t/unit/test_schedulers.py::test_modeladmin_PeriodicTaskAdmin::test_run_tasks
)
