# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

MY_PN="${PN}-sdk-python"

DESCRIPTION="Official Dropbox API Client"
HOMEPAGE="https://github.com/dropbox/dropbox-sdk-python"
SRC_URI="https://github.com/dropbox/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/stone[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-mock )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# disable integration tests need SCOPED_USER_DROPBOX_TOKEN
	test/integration/test_dropbox.py
)
