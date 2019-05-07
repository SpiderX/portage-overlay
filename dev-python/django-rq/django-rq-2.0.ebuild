# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5..7}} )

inherit distutils-r1 eutils

DESCRIPTION="An app that provides django integration for RQ (Redis Queue)"
HOMEPAGE="https://github.com/rq/django-rq"
SRC_URI="https://github.com/rq/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	>=dev-python/rq-1.0[${PYTHON_USEDEP}]
	>=dev-python/redis-py-3[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( $(python_gen_impl_dep sqlite)
		virtual/python-unittest-mock[${PYTHON_USEDEP}] )"

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}

pkg_postinst() {
	optfeature "integration with Sentry" dev-python/raven
}
