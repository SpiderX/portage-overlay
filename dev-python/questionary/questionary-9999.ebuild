# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Python library to build pretty command line user prompts"
HOMEPAGE="https://github.com/tmbo/questionary"
EGIT_REPO_URI="https://github.com/tmbo/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/prompt-toolkit[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
