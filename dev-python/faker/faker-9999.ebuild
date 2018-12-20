# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )
EGIT_REPO_URI="https://github.com/joke2k/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Python package that generates fake data"
HOMEPAGE="https://github.com/joke2k/faker"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/text-unidecode[${PYTHON_USEDEP}]
	virtual/python-ipaddress[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/pytest-runner[${PYTHON_USEDEP}]
	test? ( dev-python/email-validator[${PYTHON_USEDEP}]
		dev-python/ukpostcodeparser[${PYTHON_USEDEP}]
		virtual/python-unittest-mock[${PYTHON_USEDEP}] )"

python_test() {
	pytest -v || die "tests failed with ${EPYTHON}"
}
