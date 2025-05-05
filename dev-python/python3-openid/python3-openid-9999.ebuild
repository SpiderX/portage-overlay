# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="OpenID support for modern servers and consumers"
HOMEPAGE="https://github.com/python-social-auth/social-core"
EGIT_REPO_URI="https://github.com/python-social-auth/social-core.git"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/defusedxml[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/psycopg:2[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest

python_test() {
	"${EPYTHON}" -m unittest -v openid.test.test_suite || die "tests failed with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "integration with PostgreSQL" dev-python/psycopg:2
}
