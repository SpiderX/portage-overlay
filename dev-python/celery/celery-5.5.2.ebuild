# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Asynchronous task job queue based on distributed message passing"
HOMEPAGE="https://github.com/celery/celery"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

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
		dev-python/dnspython[${PYTHON_USEDEP}]
		dev-python/google-cloud-storage[${PYTHON_USEDEP}]
		dev-python/msgpack[${PYTHON_USEDEP}]
		dev-python/moto[${PYTHON_USEDEP}]
		dev-python/pydantic[${PYTHON_USEDEP}]
		dev-python/pymongo[${PYTHON_USEDEP}]
		dev-python/pytest-subtests[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}] )"

EPYTEST_XDIST=1
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# error
	t/unit/app/test_preload_cli.py::test_preload_options
	t/unit/bin/test_beat.py::test_cli
	t/unit/bin/test_beat.py::test_cli_quiet
	t/unit/bin/test_control.py::test_custom_remote_command
	t/unit/bin/test_control.py::test_unrecognized_remote_command
	t/unit/bin/test_control.py::test_listing_remote_commands
	t/unit/bin/test_daemonization.py::test_daemon_options_from_config
	t/unit/bin/test_worker.py::test_cli
	t/unit/bin/test_worker.py::test_cli_skip_checks
	# AttributeError: module 'pymongo' has no attribute 'uri_parser'
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_cleanup
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_init_no_mongodb
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_init_no_settings
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_init_settings_is_None
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_init_with_settings
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_init_mongodb_dnspython2_pymongo4_seedlist
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_ensure_mongodb_uri_compliance
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_reduce
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_get_connection_connection_exists
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_get_connection_no_connection_host
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_get_connection_no_connection_mongodb_uri
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_get_connection_with_authmechanism
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_get_connection_with_authmechanism_no_username
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_get_database_no_existing
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_get_database_no_existing_no_auth
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_store_result
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_store_result_with_request
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_get_task_meta_for
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_get_task_meta_for_result_extended
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_get_task_meta_for_no_result
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_save_group
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_restore_group
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_delete_group
	t/unit/backends/test_mongodb.py::test_MongoBackend::test__forget
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_prepare_client_options
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_as_uri_include_password
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_as_uri_exclude_password
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_as_uri_include_password_replica_set
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_as_uri_exclude_password_replica_set
	t/unit/backends/test_mongodb.py::test_MongoBackend::test_regression_worker_startup_info
	# assert
	t/unit/contrib/test_worker.py::test_worker::test_start_worker_with_hostname_config
	# ModuleNotFoundError: No module named 'greenlet'
	t/unit/concurrency/test_gevent.py::test_TaskPool::test_make_killable_target
	# AttributeError: 'NoneType' object has no attribute 'RedisError'
	t/unit/backends/test_redis.py::test_RedisBackend::test_exception_safe_to_retry
	# RuntimeError
	t/unit/contrib/test_worker.py::test_worker::test_start_worker_with_hostname_config
	# Failed: DID NOT RAISE
	t/unit/contrib/test_pytest.py::test_pytest_celery_marker_registration
	# assert False
	t/unit/tasks/test_stamping.py::test_canvas_stamping::test_stamping_with_replace
	# AttributeError: 'NoneType' object has no attribute 'get'
	t/unit/tasks/test_stamping.py::test_canvas_stamping::test_stamping_headers_in_options
	# RuntimeError: generator raised StopIteration
	t/unit/events/test_events.py::test_EventReceiver::test_itercapture_limit
)

python_prepare_all() {
	# remove addopts
	sed -i '/addopts/d' pyproject.toml || die "sed failed for pyproject.toml"

	distutils-r1_python_prepare_all
}

pkg_postinst() {
	#optfeature "arangodb support"
	optfeature "auth support" dev-python/pyopenssl
	#optfeature "azureblockblob support"
	optfeature "brotli support" dev-python/brotlicffi
	#optfeature "cassandra support" dev-python/cassandra-driver
	#optfeature "consul support"
	#optfeature "cosmosdbsql support"
	#optfeature "couchbase support" dev-python/couchbase
	#optfeature "couchdb support"
	#optfeature "django support"
	#optfeature "eventlet support" dev-python/eventlet
	#optfeature "gevent support" dev-python/gevent
	#optfeature "rabbitmq support" dev-python/librabbitmq
	#optfeature "lzma support"
	optfeature "memcache support" dev-python/pylibmc
	optfeature "mongodb support" dev-python/pymongo
	optfeature "msgpack support" dev-python/msgpack
	#optfeature "pymemcachee support"
	optfeature "pyro support" dev-python/pyro:4
	#optfeature "pytest support"
	optfeature "redis support" dev-db/redis dev-python/redis-py
	#optfeature "slmq support" dev-python/softlayer_messaging
	#optfeature "solar support"
	optfeature "sqlalchemy support" dev-python/sqlalchemy
	optfeature "sqs support" dev-python/boto
	optfeature "tblib support" dev-python/tblib
	optfeature "yaml support" dev-python/pyyaml
	optfeature "zookeeper support" dev-python/kazoo
	optfeature "zstd support" dev-python/zstd
}
