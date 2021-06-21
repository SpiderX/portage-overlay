# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )

inherit distutils-r1

MY_PN="${PN}-for-python"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="AutoRest swagger generator Python client runtime"
HOMEPAGE="https://github.com/Azure/msrest-for-python"
SRC_URI="https://github.com/Azure/msrest-for-python/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/certifi[${PYTHON_USEDEP}]
	>=dev-python/isodate-0.6[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/requests-oauthlib[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-python/aiodns[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.0[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/httpretty[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/trio[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests pytest

python_prepare_all() {
	# Remove tests require network access
	rm tests/asynctests/{test_pipeline,test_universal_http}.py \
		die "rm failed"

	distutils-r1_python_prepare_all
}
