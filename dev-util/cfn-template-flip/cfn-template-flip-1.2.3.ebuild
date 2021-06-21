# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

MY_PN="aws-${PN}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="AWS CloudFormation Template Flip"
HOMEPAGE="https://github.com/awslabs/aws-cfn-template-flip"
SRC_URI="https://github.com/awslabs/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.1[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests pytest

python_prepare_all() {
	# Disable coverage
	sed -i '/addopts/d' tox.ini || die "sed failed for tox.ini"

	# Disable tests with unsafe load (#659348)
	sed -i '/test_flip_to_yaml_with_longhand_functions/i@pytest.mark.skip(reason="test fails")' \
		tests/test_flip.py || die "sed failed for tests/test_flip.py"
	rm tests/test_yaml_patching.py || die "remove failed for tests/test_yaml_patching.py"

	distutils-r1_python_prepare_all
}
