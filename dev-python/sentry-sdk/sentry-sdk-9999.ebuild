# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5..7}} )
EGIT_REPO_URI="https://github.com/getsentry/sentry-python.git"

inherit distutils-r1 eutils git-r3

DESCRIPTION="Python client for Sentry"
HOMEPAGE="https://github.com/getsentry/sentry-python"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

pkg_postinst() {
	optfeature "integration with bottle" dev-python/bottle
	optfeature "integration with django" dev-python/django
	optfeature "integration with falcon" dev-python/falcon
	optfeature "integration with flask" dev-python/flask dev-python/blinker
}
