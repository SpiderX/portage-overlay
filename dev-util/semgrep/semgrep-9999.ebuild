# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
EGIT_SUBMODULES=( "OSS/cli/src/semgrep/semgrep_interfaces" )

inherit distutils-r1 git-r3

DESCRIPTION="Lightweight static analysis for many languages"
HOMEPAGE="https://github.com/semgrep/semgrep"
EGIT_REPO_URI="https://github.com/semgrep/${PN}.git"

LICENSE="LGPL-2.1"
SLOT="0"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/boltons[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/click-option-group[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/defusedxml[${PYTHON_USEDEP}]
	dev-python/exceptiongroup[${PYTHON_USEDEP}]
	dev-python/glom[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/peewee[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
	dev-python/tomli[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	dev-python/wcmatch[${PYTHON_USEDEP}]"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]
	test? ( dev-python/appdirs[${PYTHON_USEDEP}]
		dev-python/freezegun[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/requests-mock[${PYTHON_USEDEP}]
		dev-python/snapshottest[${PYTHON_USEDEP}] )"

EPYTEST_XDIST=1
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# assertion error
	cli/tests/default/unit/test_clean_project_url.py::test_get_project_url
	cli/tests/default/unit/test_metric_manager.py::test_rules_hash
	cli/tests/default/unit/test_metric_manager.py::test_configs_hash
)

EPYTEST_IGNORE=(
	# run only unit tests
	cli/tests/default/e2e
	cli/tests/default/e2e-other
	cli/tests/default/e2e-pysemgrep
	cli/tests/performance
	cli/tests/qa
)
