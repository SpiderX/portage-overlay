# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )

inherit distutils-r1

DESCRIPTION="Static code analysis tool for infrastructure-as-code"
HOMEPAGE="https://github.com/bridgecrewio/checkov"
SRC_URI="https://github.com/bridgecrewio/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/configargparse[${PYTHON_USEDEP}]
	dev-python/deep_merge[${PYTHON_USEDEP}]
	dev-python/docker-py[${PYTHON_USEDEP}]
	dev-python/dockerfile-parse[${PYTHON_USEDEP}]
	<dev-python/dpath-2[${PYTHON_USEDEP}]
	dev-python/GitPython[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/junit-xml[${PYTHON_USEDEP}]
	dev-python/networkx[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/semantic_version[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/update_checker[${PYTHON_USEDEP}]
	dev-util/cloudsplaining[${PYTHON_USEDEP}]
	dev-util/detect-secrets[${PYTHON_USEDEP}]
	dev-util/python-hcl2[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

distutils_enable_tests unittest

python_prepare_all() {
	# Disable integration test
	rm -rf integration_tests || die "rm failed for integration_tests"
	# Disable tests
	sed -i '/test_skip_mapping_false/i\\    @unittest.skip("disable")' \
		tests/common/test_platform_integration.py \
		|| die "sed failed for test_platform_integration.py"
	sed -i  -e '1 i\import unittest' \
		-e '/test_build_graph_with_linked_registry_modules/i\\    @unittest.skip("disable")' \
		tests/graph/terraform/graph_builder/test_graph_builder.py \
		|| die "sed failed for test_graph_builder.py"
	rm tests/terraform/context_parsers/test_base_parser.py || die "rm failed for test_base_parser.py"
	sed -i '/test_load_terraform_registry/i\\    @unittest.skip("disable")' \
		tests/terraform/module_loading/test_registry.py \
		|| die "sed failed for test_registry.py"
	sed -i '/test_multi_iac/i\\    @unittest.skip("disable")' \
		tests/common/runner_registry/test_runner_registry.py \
		|| die "sed failed for test_runner_registry.py"
	sed -i  -e '/test_load_inner_registry_module/i\\    @unittest.skip("disable")' \
		-e '/test_load_registry_module/i\\    @unittest.skip("disable")' \
		tests/terraform/parser/test_parser_modules.py \
		|| die "sed failed for test_parser_modules.py"
	sed -i '/test_null_var_651/i\\    @unittest.skip("disable")' \
		tests/terraform/checks/resource/aws/test_CloudfrontDistributionLogging.py \
		|| die "sed failed for test_CloudfrontDistributionLogging.py"

	distutils-r1_python_prepare_all
}
