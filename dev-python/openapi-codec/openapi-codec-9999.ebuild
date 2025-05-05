# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="An OpenAPI codec for Core API"
HOMEPAGE="https://github.com/core-api/python-openapi-codec"
EGIT_REPO_URI="https://github.com/core-api/python-${PN}.git"

LICENSE="BSD-2"
SLOT="0"

RDEPEND="dev-python/coreapi[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/legacy-cgi[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	# fix tests
	sed -i 's/assertEquals/assertEqual/' tests/test_encode.py \
		|| die "sed failed for test_encode.py"

	distutils-r1_python_prepare_all
}
