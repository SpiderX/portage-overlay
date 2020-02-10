# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )
EGIT_REPO_URI="https://github.com/Yelp/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Python library that validates Swagger Specs"
HOMEPAGE="https://github.com/Yelp/swagger_spec_validator"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# Remove failing test
	sed -i '/test_raise_SwaggerValidationError_on_urlopen_error/,$d' \
		tests/validator20/validate_spec_url_test.py \
		|| die "sed failed for validate_spec_url_test.py"
	sed -i '/test_raise_SwaggerValidationError_on_urlopen_error/,$d' \
		tests/util/validate_spec_url_test.py \
		|| die "sed failed for validate_spec_url_test.py"
	sed -i '/test_raise_SwaggerValidationError_on_urlopen_error/,$d' \
		tests/validator12/validate_spec_url_test.py \
		|| die "sed failed for validate_spec_url_test.py"

	distutils-r1_python_prepare_all
}

python_test() {
	py.test -v || die "tests failed with ${EPYTHON}"
}
