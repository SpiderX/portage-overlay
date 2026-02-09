# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1 pypi

DESCRIPTION="The HTMX Plugin for Litestar"
HOMEPAGE="https://github.com/litestar-org/litestar-htmx"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="test? ( dev-python/litestar[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
