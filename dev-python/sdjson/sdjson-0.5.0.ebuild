# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

MY_PN="singledispatch-json"

DESCRIPTION="Custom JSON Encoder for Python"
HOMEPAGE="https://github.com/domdfcoding/singledispatch-json"
SRC_URI="https://github.com/domdfcoding/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/domdf-python-tools[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="dev-python/whey[${PYTHON_USEDEP}]
	test? ( dev-python/coincidence[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}/${PN}"-0.5.0-tests.patch )

distutils_enable_tests pytest
