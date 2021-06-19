# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_8 )

inherit bash-completion-r1 distutils-r1 optfeature

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
		dev-python/msgpack[${PYTHON_USEDEP}]
		dev-python/moto[${PYTHON_USEDEP}]
		dev-python/pytest-subtests[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	# Remove pytest options
	sed -i "/addopts/d" setup.cfg \
		|| die "sed failed for setup.cfg"
	rm t/unit/contrib/test_pytest.py || die "rm failed for test_pytest.py"

	distutils-r1_python_prepare_all
}

pkg_postinst() {
	#optfeature "arangodb support"
	optfeature "auth support" dev-python/pyopenssl
	#optfeature "azureblockblob support"
	#optfeature "brotli support"
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
	#optfeature "tblib support"
	optfeature "yaml support" dev-python/pyyaml
	optfeature "zookeeper support" dev-python/kazoo
	#optfeature "zstd support"
}
