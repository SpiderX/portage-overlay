# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Static code analysis tool for infrastructure-as-code"
HOMEPAGE="https://github.com/bridgecrewio/checkov"
SRC_URI="https://github.com/bridgecrewio/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/aiodns[${PYTHON_USEDEP}]
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/aiomultiprocess[${PYTHON_USEDEP}]
	dev-python/argcomplete[${PYTHON_USEDEP}]
	dev-python/bc-detect-secrets[${PYTHON_USEDEP}]
	dev-python/bc-jsonpath-ng[${PYTHON_USEDEP}]
	dev-python/bc-python-hcl2[${PYTHON_USEDEP}]
	dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/cachetools[${PYTHON_USEDEP}]
	dev-python/charset-normalizer[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/ConfigArgParse[${PYTHON_USEDEP}]
	dev-python/cyclonedx-python-lib[${PYTHON_USEDEP}]
	dev-python/docker[${PYTHON_USEDEP}]
	dev-python/dockerfile-parse[${PYTHON_USEDEP}]
	dev-python/dpath[${PYTHON_USEDEP}]
	dev-python/GitPython[${PYTHON_USEDEP}]
	dev-python/igraph[${PYTHON_USEDEP}]
	dev-python/importlib-metadata[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/junit-xml[${PYTHON_USEDEP}]
	dev-python/license-expression[${PYTHON_USEDEP}]
	dev-python/networkx[${PYTHON_USEDEP}]
	dev-python/openai[${PYTHON_USEDEP}]
	dev-python/packageurl[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/prettytable[${PYTHON_USEDEP}]
	dev-python/pycep[${PYTHON_USEDEP}]
	dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/rustworkx[${PYTHON_USEDEP}]
	dev-python/semantic-version[${PYTHON_USEDEP}]
	>=dev-python/spdx-tools-0.8[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	dev-python/update-checker[${PYTHON_USEDEP}]
	dev-python/yarl[${PYTHON_USEDEP}]
	dev-util/cloudsplaining[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/aioresponses[${PYTHON_USEDEP}]
		dev-python/flake8[${PYTHON_USEDEP}]
		dev-python/jsonschema[${PYTHON_USEDEP}]
		dev-python/parameterized[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		dev-python/responses[${PYTHON_USEDEP}]
		dev-python/time-machine[${PYTHON_USEDEP}]
		dev-vcs/git )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# assertion error
	tests/sca_package_2/test_output_reports.py::test_get_cyclonedx_report
	tests/sca_package_2/test_output_reports.py::test_get_csv_report
	tests/bicep/graph/graph_builder/test_renderer.py::test_render_parameter
	tests/bicep/graph/graph_builder/test_renderer.py::test_render_variable
	tests/bicep/graph/graph_builder/test_renderer.py::test_render_mixed
	tests/bicep/test_graph_manager.py::test_build_graph_from_source_directory
	tests/bicep/test_graph_manager.py::test_build_graph_from_definitions
	dogfood_tests/test_checkov_dogfood.py::test_helm_framework
	tests/bicep/graph/graph_builder/test_local_graph.py::test_build_graph
)

python_prepare_all() {
	# Disable integration test
	rm -rf {cdk_,sast_,}integration_tests || die "rm failed for integration_tests"
	rm -rf performance_tests || die "rm failed for performance_tests"
	rm -rf flake8_plugins || die "rm failed for flake8_plugins"

	if use test ; then
		git init > /dev/null || die "git init failed"
		git config --global user.email "${PN}@gentoo.org" || die "git config failed"
		git config --global user.name "${PN}" || die "git config failed"
	fi

	distutils-r1_python_prepare_all
}
