# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )
EGIT_REPO_URI="https://github.com/rq/${PN}.git"

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="An app that provides django integration for RQ (Redis Queue)"
HOMEPAGE="https://github.com/rq/django-rq"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	>=dev-python/redis-py-3[${PYTHON_USEDEP}]
	>=dev-python/rq-1.2[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( $(python_gen_impl_dep sqlite) )"

distutils_enable_tests unittest

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}

pkg_postinst() {
	optfeature "integration with Sentry" dev-python/raven
}
