# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{6..7}} )
EGIT_REPO_URI="https://github.com/awslabs/serverless-application-model.git"

inherit distutils-r1 git-r3

DESCRIPTION="A library to transform SAM templates into AWS CloudFormation templates"
HOMEPAGE="https://github.com/awslabs/serverless-application-model"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="cli test"

RDEPEND=">=dev-python/boto3-1.5[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	virtual/python-enum34[${PYTHON_USEDEP}]
	cli? ( dev-python/docopt[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/mock[${PYTHON_USEDEP}]
		dev-python/parameterized[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# Do not install tests
	sed -i "/packages=find_packages/s/s'/s','tests.*'/" setup.py \
		|| die "sed for setup.py failed"
	# Disable pytest plugins
	sed -i '/addopts/s/^/#/' pytest.ini \
		|| die "sed for pytest.ini failed"

	distutils-r1_python_prepare_all
}

python_test() {
	py.test -v || die "tests failed with ${EPYTHON}"
}
