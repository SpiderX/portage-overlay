# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature

DESCRIPTION="A shim pytest plugin to enable celery.contrib.pytest"
HOMEPAGE="https://github.com/celery/pytest-celery"
SRC_URI="https://github.com/celery/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/celery[${PYTHON_USEDEP}]
	dev-python/docker[${PYTHON_USEDEP}]
	dev-python/kombu[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/pytest-docker-tools[${PYTHON_USEDEP}]
	dev-python/tenacity[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/boto3[${PYTHON_USEDEP}]
		dev-python/botocore[${PYTHON_USEDEP}]
		dev-python/python-memcached[${PYTHON_USEDEP}]
		dev-python/redis[${PYTHON_USEDEP}]
		dev-python/urllib3[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-{celery,docker-tools} )
distutils_enable_tests pytest

EPYTEST_IGNORE=( tests/integration )
EPYTEST_DESELECT=(
	# docker.errors.DockerException
	tests/smoke/test_canvas.py
	tests/smoke/test_control.py
	tests/smoke/test_failover.py
	tests/smoke/test_signals.py
	tests/smoke/test_task.py
	tests/smoke/test_worker.py
)

python_prepare_all() {
	# disable addopts
	sed -i '/addopts/,+7d' pyproject.toml || die "sed failed for pyproject.toml"

	distutils-r1_python_prepare_all
}

pkg_postinst() {
	optfeature "integration with memcached" dev-python/python-memcached
	optfeature "integration with redis" dev-python/redis
	optfeature "integration with SQS" dev-python/boto3 dev-python/botocore dev-python/urllib3
}
