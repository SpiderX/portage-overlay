# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Static code analysis tool for infrastructure-as-code"
HOMEPAGE="https://github.com/bridgecrewio/checkov"
SRC_URI="https://github.com/bridgecrewio/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/aiodns[${PYTHON_USEDEP}]
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/aiomultiprocess[${PYTHON_USEDEP}]
	dev-python/argcomplete[${PYTHON_USEDEP}]
	dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/cachetools[${PYTHON_USEDEP}]
	dev-python/charset-normalizer[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/ConfigArgParse[${PYTHON_USEDEP}]
	dev-python/cyclonedx-python-lib[${PYTHON_USEDEP}]
	dev-python/deep_merge[${PYTHON_USEDEP}]
	dev-python/docker-py[${PYTHON_USEDEP}]
	dev-python/dockerfile-parse[${PYTHON_USEDEP}]
	<dev-python/dpath-2[${PYTHON_USEDEP}]
	dev-python/GitPython[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/jsonpath-ng[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/junit-xml[${PYTHON_USEDEP}]
	dev-python/networkx[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/policyuniverse[${PYTHON_USEDEP}]
	dev-python/prettytable[${PYTHON_USEDEP}]
	dev-python/pycep[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/semantic_version[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	dev-python/update_checker[${PYTHON_USEDEP}]
	dev-util/cloudsplaining[${PYTHON_USEDEP}]
	dev-util/detect-secrets[${PYTHON_USEDEP}]
	dev-util/python-hcl2[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/aioresponses[${PYTHON_USEDEP}]
		dev-python/jsonschema[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/responses[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest

python_prepare_all() {
	# Disable integration test
	rm -rf integration_tests || die "rm failed for integration_tests"
	# Disable tests need input
	sed -i '/test_load_terraform_registry_check_cache/i\\    @unittest.skip("disable")' \
		tests/terraform/module_loading/test_registry.py \
		|| die "sed failed for test_registry.py"
	sed -i '/test_load_inner_registry_module/i\\    @unittest.skip("disable")' \
		tests/terraform/parser/test_parser_modules.py \
		|| die "sed failed for test_parser_modules.py"

	distutils-r1_python_prepare_all
}
