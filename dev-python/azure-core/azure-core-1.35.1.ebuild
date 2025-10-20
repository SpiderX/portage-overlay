# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Azure Core shared client library for Python"
HOMEPAGE="https://github.com/Azure/azure-sdk-for-python"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # https://github.com/Azure/azure-sdk-for-python/issues/9616

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/azure-storage-blob[${PYTHON_USEDEP}]
		dev-python/opentelemetry-api[${PYTHON_USEDEP}]
		dev-python/opentelemetry-instrumentation[${PYTHON_USEDEP}]
		dev-python/opentelemetry-sdk[${PYTHON_USEDEP}]
		dev-python/pytest-trio[${PYTHON_USEDEP}] )"

DOCS=( {CHANGELOG,README}.md )

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "support of aio" dev-python/aiohttp
	optfeature "support for tracing" dev-python/opentelemetry-api
}
