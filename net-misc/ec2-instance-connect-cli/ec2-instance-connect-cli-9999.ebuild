# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Python client for accessing EC2 instances via EC2 Instance Connect"
HOMEPAGE="https://github.com/aws/aws-ec2-instance-connect-cli"
EGIT_REPO_URI="https://github.com/aws/aws-ec2-instance-connect-cli.git"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-python/botocore[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_prepare_all() {
	# remove coverage from tests
	sed -i '/addopts/s/--cov ec2instanceconnectcli //' pytest.ini \
		|| die "sed failed for pytest.ini"

	distutils-r1_python_prepare_all
}
