# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1 git-r3

DESCRIPTION="The HTMX Plugin for Litestar"
HOMEPAGE="https://github.com/litestar-org/litestar-htmx"
EGIT_REPO_URI="https://github.com/litestar-org/${PN}.git"

LICENSE="MIT"
SLOT="0"

BDEPEND="test? ( dev-python/litestar[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
