# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/Yelp/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Python library that validates Swagger Specs"
HOMEPAGE="https://github.com/Yelp/swagger_spec_validator"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	# Fix QA
	sed -i '/extra_dependencies/d' setup.py || die "sed failed"

	distutils-r1_python_prepare_all
}
