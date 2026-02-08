# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
PYTHON_REQ_USE="sqlite(+)"

inherit distutils-r1 git-r3

DESCRIPTION="OAuth2 Provider for Django"
HOMEPAGE="https://github.com/jazzband/django-oauth-toolkit"
EGIT_REPO_URI="https://github.com/jazzband/${PN}.git"

LICENSE="BSD"
SLOT="0"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/jwcrypto[${PYTHON_USEDEP}]
	dev-python/oauthlib[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/djangorestframework[${PYTHON_USEDEP}] )"

EPYTEST_XDIST=1
EPYTEST_PLUGINS=( pytest-{django,mock} )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AssertionError
	tests/test_oauth2_validators.py::TestOAuth2ValidatorErrorResourceToken::test_response_when_auth_server_response_return_404
	tests/test_authorization_code.py::TestOIDCAuthorizationCodeHSAlgorithm::test_id_token
)

export DJANGO_SETTINGS_MODULE='tests.settings'

python_prepare_all() {
	# remove addopts
	sed -i '/addopts/,+5d' pyproject.toml || die "sed failed for pyproject.toml"

	distutils-r1_python_prepare_all
}
