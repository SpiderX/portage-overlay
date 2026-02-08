# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Python library to manage AWS Lambda functions"
HOMEPAGE="https://github.com/aws/aws-lambda-builders"
SRC_URI="https://github.com/aws/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="test? ( dev-python/parameterized[${PYTHON_USEDEP}]
		dev-python/pyelftools[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	tests/unit/workflows/python_pip/test_packager.py::TestPipRunner::test_build_wheel
)

EPYTEST_IGNORE=( tests/integration )
