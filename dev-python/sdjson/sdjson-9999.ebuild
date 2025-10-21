# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Custom JSON Encoder for Python"
HOMEPAGE="https://github.com/domdfcoding/singledispatch-json"
EGIT_REPO_URI="https://github.com/domdfcoding/singledispatch-json.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/domdf-python-tools[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="dev-python/whey[${PYTHON_USEDEP}]
	test? ( dev-python/coincidence[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
