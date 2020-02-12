# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )

inherit distutils-r1 eutils

DESCRIPTION="Python client for Sentry"
HOMEPAGE="https://github.com/getsentry/sentry-python"
SRC_URI="https://github.com/getsentry/sentry-python/releases/download/${PV}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="test" # no tests

RDEPEND="dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

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
