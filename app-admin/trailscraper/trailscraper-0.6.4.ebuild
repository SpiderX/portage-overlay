# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{8,10} )

inherit distutils-r1

DESCRIPTION="Command-line tool to get information out of AWS CloudTrail"
HOMEPAGE="https://github.com/flosell/trailscraper"
SRC_URI="https://github.com/flosell/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/dateparser[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
	dev-python/toolz[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/freezegun[${PYTHON_USEDEP}]
		dev-python/moto[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	# Relax requirements
	sed -i 's/==/>=/g' requirements.txt || die "sed failed for requirements.txt"

	distutils-r1_python_prepare_all
}
