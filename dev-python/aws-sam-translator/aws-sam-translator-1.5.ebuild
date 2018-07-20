# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

MY_PN="serverless-application-model"
MY_P="${MY_PN}-${PV}"

inherit distutils-r1

DESCRIPTION="A library to transform SAM templates into AWS CloudFormation templates"
HOMEPAGE="https://github.com/awslabs/serverless-application-model"
SRC_URI="https://github.com/awslabs/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/botocore[${PYTHON_USEDEP}]
	dev-python/docutils[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/s3transfer[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/functools32[${PYTHON_USEDEP}]' 'python2*')
	virtual/python-enum34[${PYTHON_USEDEP}]
	virtual/python-futures[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/nose-parameterized[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
	)"

S="${WORKDIR}/${MY_P}"

RESTRICT="test"

src_prepare() {
	default

	# Do not install tests
	sed -i "/packages=find_packages/s/s'/s','tests.*'/" setup.py \
		|| die "sed for setup.py failed"
	# Fix import in tests
	sed -i '/from parameterized/s/parameterized/nose_parameterized/' \
		tests/policy_template_processor/test_schema.py \
		|| die "sed for test_schema.py failed"
	sed -i '/from parameterized/s/parameterized/nose_parameterized/' \
		tests/swagger/test_swagger.py \
		|| die "sed for test_swagger.py failed"
	sed -i '/from parameterized/s/parameterized/nose_parameterized/' \
		tests/plugins/globals/test_globals.py \
		|| die "sed for test_globals.py failed"
	sed -i '/from parameterized/s/parameterized/nose_parameterized/' \
		tests/test_intrinsics.py \
		|| die "sed for test_intrinsics.py failed"
	sed -i '/from parameterized/s/parameterized/nose_parameterized/' \
		tests/translator/test_translator.py \
		|| die "sed for test_translator.py failed"
}

python_test() {
	esetup.py test || die "Tests failed under ${EPYTHON}"
}
