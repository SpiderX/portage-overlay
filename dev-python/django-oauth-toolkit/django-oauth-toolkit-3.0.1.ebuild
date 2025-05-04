# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="OAuth2 Provider for Django"
HOMEPAGE="https://github.com/jazzband/django-oauth-toolkit"
SRC_URI="https://github.com/jazzband/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/jwcrypto[${PYTHON_USEDEP}]
	dev-python/oauthlib[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
BDEPEND="test? ( $(python_gen_impl_dep sqlite)
		dev-python/djangorestframework[${PYTHON_USEDEP}]
		dev-python/pytest-django[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}] )"

EPYTEST_XDIST=1
distutils_enable_tests pytest

python_prepare_all() {
	# remove addopts
	sed -i '/addopts/,+5d' pyproject.toml || die "sed failed for pyproject.toml"

	# Disable test (network-sandbox)
	sed -i '/test_response_when_auth_server_response_return_404/i\\    @pytest.mark.skip("disable")' \
		tests/test_oauth2_validators.py || die "sed failed for test_oauth2_validators.py"

	distutils-r1_python_prepare_all
}

python_test() {
	DJANGO_SETTINGS_MODULE=tests.settings PYTHONPATH=. \
		py.test -v || die "tests failed with ${EPYTHON}"
}
