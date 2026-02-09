# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Snowplow event tracker for Python"
HOMEPAGE="https://github.com/snowplow/snowplow-python-tracker"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/attrs[${PYTHON_USEDEP}]
		dev-python/httmock[${PYTHON_USEDEP}]
		dev-python/freezegun[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
