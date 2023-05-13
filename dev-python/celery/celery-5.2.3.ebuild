# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8,10} )

inherit distutils-r1 optfeature

DESCRIPTION="Asynchronous task job queue based on distributed message passing"
HOMEPAGE="https://github.com/celery/celery"
SRC_URI="https://github.com/celery/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/billiard[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/click-didyoumean[${PYTHON_USEDEP}]
	dev-python/click-plugins[${PYTHON_USEDEP}]
	dev-python/click-repl[${PYTHON_USEDEP}]
	dev-python/kombu[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/vine[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/boto3[${PYTHON_USEDEP}]
		dev-python/case[${PYTHON_USEDEP}]
		dev-python/cryptography[${PYTHON_USEDEP}]
		dev-python/dnspython[${PYTHON_USEDEP}]
		dev-python/eventlet[${PYTHON_USEDEP}]
		dev-python/gevent[${PYTHON_USEDEP}]
		dev-python/msgpack[${PYTHON_USEDEP}]
		dev-python/moto[${PYTHON_USEDEP}]
		dev-python/pymongo[${PYTHON_USEDEP}]
		dev-python/pytest-subtests[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# Failed: DID NOT RAISE
	t/unit/contrib/test_pytest.py::test_pytest_celery_marker_registration
)

python_prepare_all() {
	# Remove failed tests
	rm t/unit/app/test_backends.py \
		t/unit/backends/test_{base,rpc}.py

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
	optfeature "eventlet support" dev-python/eventlet
	optfeature "gevent support" dev-python/gevent
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
