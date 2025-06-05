# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="AWS Cryptographic Internal ComAmazonawsDynamodb"
HOMEPAGE="https://github.com/aws/aws-cryptographic-material-providers-library"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # no tests

RDEPEND="dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/aws-cryptography-internal-standard-library[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
