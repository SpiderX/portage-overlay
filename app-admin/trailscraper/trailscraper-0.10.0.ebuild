# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Command-line tool to get information out of AWS CloudTrail"
HOMEPAGE="https://github.com/flosell/trailscraper"
SRC_URI="https://github.com/flosell/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/dateparser[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
	dev-python/toolz[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/moto[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}/${PN}"-0.10.0-boto_service-nogz.patch
	"${FILESDIR}/${PN}"-0.10.0-test.patch )

EPYTEST_PLUGINS=( freezegun )
distutils_enable_tests pytest

src_prepare() {
	# Relax requirements
	sed -i 's/==/>=/g' pyproject.toml || die "sed failed for pyproject.toml"

	# support for modern moto
	sed -i 's/mock_s3/mock_aws/g' tests/{integration/cli_download_s3,s3/s3_download,s3/download_recursive}_test.py \
		|| die "sed failed for tests"

	distutils-r1_src_prepare
}
