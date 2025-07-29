# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Function decoration for backoff and retry"
HOMEPAGE="https://github.com/litl/backoff"
EGIT_REPO_URI="https://github.com/litl/backoff.git"

LICENSE="MIT"
SLOT="0"

PATCHES=( "${FILESDIR}/${PN}"-2.2.1-tests.patch )

DOCS=( README.rst )

BDEPEND="test? ( dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/responses[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
