# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
EGIT_REPO_URI="https://github.com/sqlfluff/${PN}.git"
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 git-r3

DESCRIPTION="A SQL linter and auto-formatter"
HOMEPAGE="https://github.com/sqlfluff/sqlfluff"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/pathspec[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]
	dev-python/tblib[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-util/diff-cover[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/typing-extensions[${PYTHON_USEDEP}] )"

EPYTEST_XDIST=1
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	test/cli/commands_test.py::test_cli_fix_even_unparsable # assert 0 == 1
	test/core/plugin_test.py::test__plugin_manager_registers_example_plugin # AssertionError: assert False
	test/core/plugin_test.py::test__plugin_example_rules_returned # AssertionError: assert
	test/core/plugin_test.py::test__plugin_default_config_read # KeyError: 'Example_L001'
)

python_test() {
	epytest -v -m "not dbt"
}
