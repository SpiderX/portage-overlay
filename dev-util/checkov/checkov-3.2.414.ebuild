# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

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
	dev-python/configargparse[${PYTHON_USEDEP}]
	<dev-python/cyclonedx-python-lib-8[${PYTHON_USEDEP}]
	dev-python/docker[${PYTHON_USEDEP}]
	dev-python/dockerfile-parse[${PYTHON_USEDEP}]
	dev-python/dpath[${PYTHON_USEDEP}]
	dev-python/gitpython[${PYTHON_USEDEP}]
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
	dev-python/yarl[${PYTHON_USEDEP}]
	dev-util/cloudsplaining[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/gitpython[${PYTHON_USEDEP}]
		dev-python/jsonschema[${PYTHON_USEDEP}]
		dev-python/parameterized[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-vcs/git )"

EPYTEST_XDIST=1
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# assertion error
	tests/secrets/test_plugin_multiline_json.py::TestCombinatorPluginMultilineJson::test_non_multiline_pair_time_limit_creating_report
	tests/terraform/runner/test_runner.py::TestRunnerValid_1_False::test_terraform_multiple_module_versions
	tests/terraform/runner/test_runner.py::TestRunnerValid_2_True::test_terraform_multiple_module_versions
	tests/sca_package_2/test_output_reports.py::test_get_csv_report
	dogfood_tests/test_checkov_dogfood.py::test_helm_framework
)
EPYTEST_IGNORE=(
	# integration test
	cdk_integration_tests
	sast_integration_tests
	integration_tests
	performance_tests
	flake8_plugins
	# ignore failed graph tests
	tests/ansible/checks/graph_checks
	tests/arm/graph_builder/checks
	tests/bicep/graph/checks
	tests/cloudformation/graph/checks
	tests/common/graph/checks
	tests/kubernetes/graph/checks
	tests/github_actions/checks
	tests/dockerfile/graph_builder/checks
	# ignore failedtest
	tests/common/bridgecrew/vulnerability_scanning/integrations/test_docker_image_scanning.py
	tests/common/bridgecrew/vulnerability_scanning/integrations/test_package_scanning.py
	tests/common/output/test_spdx.py
	tests/common/utils/test_http_utils.py
	tests/sca_image/test_runner.py
	tests/github/checks/test_python_policies.py
)

python_prepare_all() {
	if use test ; then
		git init > /dev/null || die "git init failed"
		git config --global user.email "${PN}@gentoo.org" || die "git config failed"
		git config --global user.name "${PN}" || die "git config failed"
	fi

	distutils-r1_python_prepare_all
}
