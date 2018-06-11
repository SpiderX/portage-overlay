# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )
EGIT_REPO_URI="https://github.com/awslabs/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="AWS CloudFormation Linter"
HOMEPAGE="https://github.com/awslabs/cfn-python-lint"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/unittest2[${PYTHON_USEDEP}] )"

python_test() {
	pushd test || die "failed switching to test"
	unit2 || die "tests failed with ${EPYTHON}"
	popd || die "failed switching from test"
}
