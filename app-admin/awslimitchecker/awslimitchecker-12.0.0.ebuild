# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )

inherit distutils-r1

DESCRIPTION="Utility to check AWS resource limits and usage"
HOMEPAGE="https://github.com/jantman/awslimitchecker"
SRC_URI="https://github.com/jantman/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="AGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/botocore[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	dev-python/versionfinder[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/freezegun[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/onetimepass[${PYTHON_USEDEP}]
		dev-python/testfixtures[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	# Do not reconfigure pytest
	sed -i '/pytest_configure/,+5d' awslimitchecker/tests/conftest.py \
		|| die "sed failed for conftest.py"

	distutils-r1_python_prepare_all
}

python_test() {
	AWS_DEFAULT_REGION=us-east-1 epytest
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}
