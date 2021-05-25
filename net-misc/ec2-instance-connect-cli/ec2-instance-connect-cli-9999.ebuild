# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
EGIT_REPO_URI="https://github.com/aws/aws-ec2-instance-connect-cli.git"

inherit distutils-r1 git-r3

MY_PN="aws-${PN}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python client for accessing EC2 instances via EC2 Instance Connect"
HOMEPAGE="https://github.com/aws/aws-ec2-instance-connect-cli"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/botocore[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest

python_prepare_all() {
	# Remove coverage from tests
	sed -i '/addopts/s/--cov ec2instanceconnectcli //' pytest.ini \
		|| die "sed failed for pytest.ini"

	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
	find "${D}" -name '*.cmd' -delete || die "cmd removal failed"
}
