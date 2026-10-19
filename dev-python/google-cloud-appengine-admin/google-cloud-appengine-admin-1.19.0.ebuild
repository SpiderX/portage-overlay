# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="Python Client for App Engine Admin"
HOMEPAGE="https://github.com/googleapis/google-cloud-python"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="dev-python/google-api-core[grpc,${PYTHON_USEDEP}]
	dev-python/google-auth[${PYTHON_USEDEP}]
	dev-python/proto-plus[${PYTHON_USEDEP}]
	dev-python/protobuf[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest
