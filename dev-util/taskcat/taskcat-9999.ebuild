# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{7,8} )
EGIT_REPO_URI="https://github.com/aws-quickstart/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="An OpenSource Cloudformation Deployment Framework"
HOMEPAGE="https://github.com/aws-quickstart/taskcat"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/botocore[${PYTHON_USEDEP}]
	dev-python/cfn-python-lint[${PYTHON_USEDEP}]
	dev-python/dataclasses-jsonschema[${PYTHON_USEDEP}]
	dev-python/docker-py[${PYTHON_USEDEP}]
	dev-python/dulwich[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/reprint[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]
	dev-python/yattag[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest

python_prepare_all() {
	# Remove test needs docker and network
	rm tests/test_lambda_package.py || die "rm test_lambda_package.py failed"
	rm tests/test_amiupdater.py || die "rm test_amiupdater.py failed"

	distutils-r1_python_prepare_all
}
