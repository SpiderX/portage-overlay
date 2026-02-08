# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12,13} )

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
		dev-python/gevent[${PYTHON_USEDEP}]
		dev-python/google-cloud-firestore[${PYTHON_USEDEP}]
		dev-python/google-cloud-storage[${PYTHON_USEDEP}]
		dev-python/msgpack[${PYTHON_USEDEP}]
		dev-python/moto[${PYTHON_USEDEP}]
		dev-python/pydantic[${PYTHON_USEDEP}]
		dev-python/pymongo[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/tblib[${PYTHON_USEDEP}]
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
	# AssertionError
	t/unit/tasks/test_stamping.py
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
