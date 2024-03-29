# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="A SQL linter and auto-formatter"
HOMEPAGE="https://github.com/sqlfluff/sqlfluff"
SRC_URI="https://github.com/sqlfluff/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # not load config

RDEPEND="dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/pathspec[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]
	dev-python/tblib[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-util/diff-cover[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/typing-extensions[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	# Remove failed tests
	rm plugins/sqlfluff-plugin-example/test/rules/rule_test_cases_test.py \
		|| die "rm failed for rule_test_cases_test.py"
	rm test/core/plugin_test.py || die "rm failed for plugin_test.py"

	distutils-r1_python_prepare_all
}

python_test() {
	pytest -v -m "not dbt" || die "tests failed with ${EPYTHON}"
}
