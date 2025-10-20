# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="The Python MONGODB-AWS authentication mechanism for PyMongo"
HOMEPAGE="https://github.com/mongodb/pymongo-auth-aws"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/botocore[${PYTHON_USEDEP}]"
BDEPEND="dev-python/hatch-requirements-txt[${PYTHON_USEDEP}]
	test? ( dev-python/dnspython[${PYTHON_USEDEP}]
		dev-python/pymongo[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
