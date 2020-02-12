# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )
EGIT_REPO_URI="https://github.com/getsentry/sentry-python.git"

inherit distutils-r1 eutils git-r3

DESCRIPTION="Python client for Sentry"
HOMEPAGE="https://github.com/getsentry/sentry-python"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="test" # lots of failures

RDEPEND="dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/eventlet[${PYTHON_USEDEP}]
		dev-python/gevent[${PYTHON_USEDEP}]
		dev-python/flask-login[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-forked[${PYTHON_USEDEP}]
		dev-python/pytest-localserver[${PYTHON_USEDEP}]
		dev-python/werkzeug[${PYTHON_USEDEP}] )"

pkg_postinst() {
	optfeature "integration with aiohttp" dev-python/aiohttp
	optfeature "integration with bottle" dev-python/bottle
	optfeature "integration with celery" dev-python/celery
	optfeature "integration with django" dev-python/django
	optfeature "integration with falcon" dev-python/falcon
	optfeature "integration with flask" dev-python/flask dev-python/blinker
	optfeature "integration with rq" dev-python/rq
	optfeature "integration with sqlalchenmy" dev-python/sqlalchemy
	optfeature "integration with tornado" www-servers/tornado
}
