# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/p1c2u/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="OpenAPI schema validation for Python"
HOMEPAGE="https://github.com/p1c2u/openapi-schema-validator"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/isodate[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/rfc3339-validator[${PYTHON_USEDEP}]
	dev-python/strict-rfc3339[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest

python_prepare_all() {

	# remove test options
	sed -i '/addopts/,+8d' pyproject.toml || die "sed failed"

	distutils-r1_python_prepare_all
}
