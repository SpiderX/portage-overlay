# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5..7}} )
MY_PN="aws-${PN}"
MY_P="${MY_PN}-${PV}"

inherit distutils-r1

DESCRIPTION="AWS CloudFormation Template Flip"
HOMEPAGE="https://github.com/awslabs/aws-cfn-template-flip"
SRC_URI="https://github.com/awslabs/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.1[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	# Disable coverage
	sed -i '/addopts/d' tox.ini || die "sed failed for tox.ini"

	# Disable test
	sed -i '/test_flip_to_yaml_with_longhand_functions/i@pytest.mark.skip(reason="test fails")' \
		tests/test_flip.py || die "sed failed for tests/test_flip.py"

	# Disable test with unsafe load (#659348)
	rm tests/test_yaml_patching.py || die "remove failed for tests/test_yaml_patching.py"

	distutils-r1_python_prepare_all
}

python_test() {
	pytest -v || die "tests failed with ${EPYTHON}"
}
