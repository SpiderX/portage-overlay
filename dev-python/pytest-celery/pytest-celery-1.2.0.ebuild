# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="A shim pytest plugin to enable celery.contrib.pytest"
HOMEPAGE="https://github.com/celery/pytest-celery"
SRC_URI="https://github.com/celery/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # needs docker

RDEPEND="dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/botocore[${PYTHON_USEDEP}]
	dev-python/celery[${PYTHON_USEDEP}]
	dev-python/docker[${PYTHON_USEDEP}]
	dev-python/kombu[${PYTHON_USEDEP}]
	dev-python/redis[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/pytest-docker-tools[${PYTHON_USEDEP}]
	dev-python/python-memcached[${PYTHON_USEDEP}]
	dev-python/tenacity[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_prepare_all() {
	# disable addopts
	sed -i '/addopts/,+7d' pyproject.toml || die "sed failed for pyproject.toml"

	distutils-r1_python_prepare_all
}
