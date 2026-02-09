# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="The official Python SDK for Sentry.io"
HOMEPAGE="https://github.com/getsentry/sentry-python"
EGIT_REPO_URI="https://github.com/getsentry/sentry-python.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]"
BDEPEND="test? ( app-arch/brotli[python,${PYTHON_USEDEP}]
		dev-python/asyncpg[${PYTHON_USEDEP}]
		dev-python/django[${PYTHON_USEDEP}]
		dev-python/executing[${PYTHON_USEDEP}]
		dev-python/fakeredis[${PYTHON_USEDEP}]
		dev-python/fastapi[${PYTHON_USEDEP}]
		dev-python/flask[${PYTHON_USEDEP}]
		dev-python/flask-login[${PYTHON_USEDEP}]
		dev-python/httpcore[${PYTHON_USEDEP}]
		dev-python/httpx[${PYTHON_USEDEP}]
		dev-python/jsonschema[${PYTHON_USEDEP}]
		dev-python/litestar[${PYTHON_USEDEP}]
		dev-python/protobuf[${PYTHON_USEDEP}]
		dev-python/pymongo[${PYTHON_USEDEP}]
		dev-python/responses[${PYTHON_USEDEP}]
		dev-python/rq[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}]
		dev-python/starlette[${PYTHON_USEDEP}] )"

DOCS=( {CHANGELOG,MIGRATION_GUIDE,README}.md )

export DJANGO_SETTINGS_MODULE='tests.integrations.django.myapp.settings'

EPYTEST_PLUGINS=( pytest-{asyncio,forked,localserver} )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AssertionError
	tests/test_client.py::test_socks_proxy
	tests/test_client.py::test_databag_depth_stripping
	tests/test_client.py::test_databag_breadth_stripping
	tests/test_utils.py::test_datetime_from_isoformat
	tests/test_utils.py::test_datetime_from_isoformat_with_py_36_or_lower
	tests/test_utils.py::test_default_release
)
EPYTEST_IGNORE=( tests/integrations )

src_prepare() {
	default

	# remove coverage
	sed -i '/addopts/d' pyproject.toml || die "sed failed for pyproject.toml"
}

pkg_postinst() {
	optfeature "integration with aiohttp" dev-python/aiohttp
	optfeature "integration with asyncpg" dev-python/asyncpg
	optfeature "integration with bottle" dev-python/bottle
	optfeature "integration with celery" dev-python/celery
	optfeature "integration with django" dev-python/django
	optfeature "integration with fastapi" dev-python/fastapi
	optfeature "integration with flask" dev-python/flask dev-python/blinker dev-python/markupsafe
	optfeature "integration with grpcio" dev-python/grpcio dev-python/protobuf
	optfeature "integration with http2" dev-python/httpcore
	optfeature "integration with httpx" dev-python/httpx
	optfeature "integration with huggingface_hub" sci-ml/huggingface_hub
	optfeature "integration with litestar" dev-python/litestar
	optfeature "integration with loguru" dev-python/loguru
	optfeature "integration with openai" dev-python/openai
	optfeature "integration with pure-eval" dev-python/pure-eval dev-python/executing dev-python/asttokens
	optfeature "integration with pymongo" dev-python/pymongo
	optfeature "integration with quart" dev-python/quart dev-python/blinker
	optfeature "integration with rq" dev-python/rq
	optfeature "integration with sqlalchemy" dev-python/sqlalchemy
	optfeature "integration with starlette" dev-python/starlette
	optfeature "integration with tornado" dev-python/tornado
}
