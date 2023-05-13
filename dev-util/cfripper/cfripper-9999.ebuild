# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,10} )
EGIT_REPO_URI="https://github.com/Skyscanner/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Analysing CloudFormation templates for security compliance"
HOMEPAGE="https://github.com/Skyscanner/cfripper"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/importlib_metadata[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/pluggy[${PYTHON_USEDEP}]
	dev-python/pycfmodel[${PYTHON_USEDEP}]
	dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/pydash[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/s3transfer[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	dev-python/zipp[${PYTHON_USEDEP}]
	dev-util/cfn-template-flip[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/moto[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
