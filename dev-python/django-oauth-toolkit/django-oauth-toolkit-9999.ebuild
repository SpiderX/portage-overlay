# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/jazzband/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="OAuth2 Provider for Django"
HOMEPAGE="https://github.com/jazzband/django-oauth-toolkit"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/jwcrypto[${PYTHON_USEDEP}]
	dev-python/oauthlib[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
BDEPEND="test? ( $(python_gen_impl_dep sqlite)
		dev-python/djangorestframework[${PYTHON_USEDEP}]
		dev-python/pytest-django[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	# Remove coverage
	sed -i '/--cov/d' tox.ini || die "sed failed for tox.ini"

	# Don't install tests
	sed -i '/exclude/s/ts/ts,tests.*/' setup.cfg \
		|| die "sed failed for setup.cfg"

	# Disable test (network-sandbox)
	sed -i '/test_response_when_auth_server_response_return_404/i\\    @pytest.mark.skip("disable")' \
		tests/test_oauth2_validators.py || die "sed failed for test_oauth2_validators.py"

	distutils-r1_python_prepare_all
}

python_test() {
	DJANGO_SETTINGS_MODULE=tests.settings PYTHONPATH=. \
		py.test -v || die "tests failed with ${EPYTHON}"
}
