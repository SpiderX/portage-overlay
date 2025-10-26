# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="Asynchronous task job queue based on distributed message passing"
HOMEPAGE="https://github.com/celery/celery"
EGIT_REPO_URI="https://github.com/celery/${PN}.git"

LICENSE="BSD"
SLOT="0"

RDEPEND="dev-python/billiard[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/click-didyoumean[${PYTHON_USEDEP}]
	dev-python/click-plugins[${PYTHON_USEDEP}]
	dev-python/click-repl[${PYTHON_USEDEP}]
	dev-python/kombu[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/vine[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/azure-storage-blob[${PYTHON_USEDEP}]
		dev-python/boto3[${PYTHON_USEDEP}]
		dev-python/cryptography[${PYTHON_USEDEP}]
		dev-python/dnspython[${PYTHON_USEDEP}]
		dev-python/exceptiongroup[${PYTHON_USEDEP}]
		dev-python/gevent[${PYTHON_USEDEP}]
		dev-python/google-cloud-firestore[${PYTHON_USEDEP}]
		dev-python/google-cloud-storage[${PYTHON_USEDEP}]
		dev-python/msgpack[${PYTHON_USEDEP}]
		dev-python/moto[${PYTHON_USEDEP}]
		dev-python/pydantic[${PYTHON_USEDEP}]
		dev-python/pymongo[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/tzlocal[${PYTHON_USEDEP}] )"

EPYTEST_XDIST=1
EPYTEST_PLUGINS=( pytest-{celery,subtests,xdist} )
distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# error
	t/unit/app/test_preload_cli.py
	t/unit/bin/test_beat.py
	t/unit/bin/test_control.py
	t/unit/bin/test_daemonization.py
	t/unit/bin/test_worker.py
)
EPYTEST_DESELECT=(
	# assert
	t/unit/contrib/test_pytest.py::test_pytest_celery_marker_registration
	t/unit/contrib/test_rdb.py::test_Rdb::test_debugger
	t/unit/contrib/test_rdb.py::test_Rdb::test_set_trace
	t/unit/contrib/test_rdb.py::test_Rdb::test_rdb
	t/unit/contrib/test_rdb.py::test_Rdb::test_get_avail_port
	t/unit/tasks/test_stamping.py::test_canvas_stamping::test_stamping_with_replace
	t/unit/contrib/test_worker.py::test_worker::test_start_worker
	t/unit/contrib/test_worker.py::test_worker::test_start_worker_with_exception
	t/unit/contrib/test_worker.py::test_worker::test_start_worker_with_hostname_config
	# AttributeError
	t/unit/app/test_app.py::test_App::test_worker_main
	t/unit/app/test_app.py::test_App::test_start
	t/unit/contrib/test_pytest.py::test_pytest_celery_marker_registration
	t/unit/events/test_dumper.py::test_on_event_task_received
	t/unit/events/test_dumper.py::test_on_event_non_task
	t/unit/tasks/test_stamping.py::test_canvas_stamping::test_stamping_headers_in_options
	# failed
	t/unit/events/test_events.py::test_EventReceiver::test_itercapture_limit
)

python_prepare_all() {
	# remove addopts
	sed -i '/addopts/d' pyproject.toml || die "sed failed for pyproject.toml"

	distutils-r1_python_prepare_all
}

pkg_postinst() {
	optfeature "auth support" dev-python/pyopenssl
	optfeature "aws support" dev-python/boto3
	optfeature "azure support" dev-python/azure-storage-blob
	optfeature "brotli support" dev-python/brotlicffi
	optfeature "cryptography support" dev-python/cryptography
	optfeature "django support" dev-python/django
	optfeature "gcs support" dev-python/google-cloud-storage dev-python/google-cloud-firestore
	optfeature "gevent support" dev-python/gevent
	optfeature "memcache support" dev-python/python-memcached
	optfeature "mongodb support" dev-python/pymongo
	optfeature "msgpack support" dev-python/msgpack
	optfeature "pydantic support" dev-python/pydantic
	optfeature "pyro support" dev-python/pyro:4
	optfeature "redis support" dev-db/redis dev-python/redis-py
	optfeature "sqlalchemy support" dev-python/sqlalchemy
	optfeature "tblib support" dev-python/tblib
	optfeature "yaml support" dev-python/pyyaml
	optfeature "zstd support" dev-python/zstd
}
