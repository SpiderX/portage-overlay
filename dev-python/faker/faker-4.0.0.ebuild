# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6..8} )

inherit distutils-r1

DESCRIPTION="Python package that generates fake data"
HOMEPAGE="https://github.com/joke2k/faker"
SRC_URI="https://github.com/joke2k/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/text-unidecode[${PYTHON_USEDEP}]
	virtual/python-ipaddress[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/pytest-runner[${PYTHON_USEDEP}]
	test? ( dev-python/freezegun[${PYTHON_USEDEP}]
		dev-python/more-itertools[${PYTHON_USEDEP}]
		dev-python/random2[${PYTHON_USEDEP}]
		dev-python/ukpostcodeparser[${PYTHON_USEDEP}]
		dev-python/validators[${PYTHON_USEDEP}] )"

python_test() {
	py.test -v || die "tests failed with ${EPYTHON}"
}
