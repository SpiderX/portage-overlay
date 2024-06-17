# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
EGIT_REPO_URI="https://github.com/salesforce/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="AWS IAM Security Assessment tool"
HOMEPAGE="https://github.com/salesforce/cloudsplaining"

LICENSE="BSD"
SLOT="0"

RDEPEND="dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/botocore[${PYTHON_USEDEP}]
	dev-python/cached-property[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/click-option-group[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/markdown[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/schema[${PYTHON_USEDEP}]
	dev-util/policy-sentry[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
