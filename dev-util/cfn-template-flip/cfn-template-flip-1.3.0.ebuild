# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

MY_PN="aws-${PN}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="AWS CloudFormation Template Flip"
HOMEPAGE="https://github.com/awslabs/aws-cfn-template-flip"
SRC_URI="https://github.com/awslabs/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.gh.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# TypeError: load() missing 1 required positional argument: 'Loader'
	tests/test_yaml_patching.py::test_yaml_no_ordered_dict
)

python_prepare_all() {
	# disable coverage
	sed -i '/addopts/d' tox.ini || die "sed failed for tox.ini"

	distutils-r1_python_prepare_all
}
