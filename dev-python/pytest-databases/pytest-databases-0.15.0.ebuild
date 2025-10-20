# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Reusable database fixtures for any and all databases"
HOMEPAGE="https://github.com/litestar-org/pytest-databases"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"

RDEPEND="dev-python/docker[${PYTHON_USEDEP}]
	dev-python/filelock[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]"

EPYTEST_XDIST=1
distutils_enable_tests pytest

pkg_postinst() {
	optfeature "integration with azure-storage" dev-python/azure-storage-blob
	optfeature "integration with bigquery" dev-python/google-cloud-bigquery
	optfeature "integration with cockroachdb" dev-python/psycopg:3
	optfeature "integration with dragonfly" dev-python/redis
	optfeature "integration with elasticsearch" dev-python/elasticsearch
	optfeature "integration with keydb" dev-python/redis
	optfeature "integration with minio" dev-python/minio
	optfeature "integration with mssql" dev-python/pymssql
	optfeature "integration with mysql" dev-python/mysql-connector-python
	optfeature "integration with oracle" dev-python/oracledb
	optfeature "integration with postgres" dev-python/psycopg:3
	optfeature "integration with redis" dev-python/redis
	optfeature "integration with spanner" dev-python/google-cloud-spanner
	optfeature "integration with valkey" dev-python/valkey
}
