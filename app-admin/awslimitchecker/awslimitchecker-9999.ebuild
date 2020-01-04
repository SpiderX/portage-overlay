# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..7} )
EGIT_REPO_URI="https://github.com/jantman/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Utility to check AWS resource limits and usage"
HOMEPAGE="https://github.com/jantman/awslimitchecker"
SRC_URI=""

LICENSE="AGPL-3+"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="test"

RDEPEND="dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/botocore[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
	dev-python/versionfinder[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/freezegun[${PYTHON_USEDEP}]
		dev-python/onetimepass[${PYTHON_USEDEP}]
		dev-python/testfixtures[${PYTHON_USEDEP}]
		virtual/python-unittest-mock[${PYTHON_USEDEP}] )"

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}
