# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11,12} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Python Social Auth - Core"
HOMEPAGE="https://github.com/python-social-auth/social-core"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/defusedxml[${PYTHON_USEDEP}]
	dev-python/oauthlib[${PYTHON_USEDEP}]
	dev-python/pyjwt[${PYTHON_USEDEP}]
	dev-python/python3-openid[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/requests-oauthlib[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/python3-saml[${PYTHON_USEDEP}]
		dev-python/responses[${PYTHON_USEDEP}] )"

EPYTEST_XDIST=1
distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}

pkg_postinst() {
	optfeature "integration with OpenID Connect" dev-python/pyjwt
	optfeature "integration with SAML" dev-python/python3-saml
}
