# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )

inherit distutils-r1 optfeature

DESCRIPTION="An app that provides django integration for RQ (Redis Queue)"
HOMEPAGE="https://github.com/rq/django-rq"
SRC_URI="https://github.com/rq/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/redis-py[${PYTHON_USEDEP}]
	dev-python/rq[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( $(python_gen_impl_dep sqlite) )"

distutils_enable_tests unittest

python_test() {
	DJANGO_SETTINGS_MODULE=django_rq.tests.settings PYTHONPATH=. python -m unittest discover -v
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}

pkg_postinst() {
	optfeature "integration with Sentry" dev-python/raven
}
