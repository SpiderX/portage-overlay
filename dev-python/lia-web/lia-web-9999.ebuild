# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="A library for working with web frameworks"
HOMEPAGE="https://github.com/patrick91/lia"
EGIT_REPO_URI="https://github.com/patrick91/lia.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # https://github.com/pytest-dev/pytest-django/issues/589

RDEPEND="dev-python/typing-extensions[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest
