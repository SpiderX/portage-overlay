# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="IAM Policy Validator for AWS CloudFormation"
HOMEPAGE="https://github.com/awslabs/aws-cloudformation-iam-policy-validator"
EGIT_REPO_URI="https://github.com/awslabs/aws-cloudformation-iam-policy-validator.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

export AWS_DEFAULT_REGION=us-east-1
export TEST_MODE=OFFLINE
