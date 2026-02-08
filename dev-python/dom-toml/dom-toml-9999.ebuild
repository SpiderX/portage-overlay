# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Dom's tools for Tom's Obvious, Minimal Language"
HOMEPAGE="https://github.com/domdfcoding/dom_toml"
EGIT_REPO_URI="https://github.com/domdfcoding/dom_toml.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/domdf-python-tools[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/coincidence[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
