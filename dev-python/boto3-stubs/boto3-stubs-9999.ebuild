# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Type annotations for boto3"
HOMEPAGE="https://github.com/youtype/mypy_boto3_builder"
EGIT_REPO_URI="https://github.com/youtype/mypy_boto3_builder.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/botocore-stubs[${PYTHON_USEDEP}]
	dev-python/types-s3transfer[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
