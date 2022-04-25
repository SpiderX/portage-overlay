# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/tmbo/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Python library to build pretty command line user prompts"
HOMEPAGE="https://github.com/tmbo/questionary"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/prompt_toolkit[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# TypeError: <lambda>() missing 1 required positional argument: 'strike'
	tests/prompts/test_common.py::test_print_with_style
)
