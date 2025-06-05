# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature pypi

MY_PN="powertools-lambda-python"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A suite of Python utilities for AWS Lambda functions"
HOMEPAGE="https://github.com/aws-powertools/powertools-lambda-python"
SRC_URI="https://github.com/aws-powertools/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.gh.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/aws-encryption-sdk[${PYTHON_USEDEP}]
		dev-python/aws-xray-sdk[${PYTHON_USEDEP}]
		dev-python/boto3[${PYTHON_USEDEP}]
		dev-python/jsonpath-ng[${PYTHON_USEDEP}]
		dev-python/multiprocess[${PYTHON_USEDEP}]
		dev-python/pydantic[${PYTHON_USEDEP}]
		dev-python/pydantic-settings[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/pytest-socket[${PYTHON_USEDEP}]
		dev-python/redis[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# fails
	tests/performance/data_masking/test_perf_data_masking.py::test_data_masking_init
	tests/performance/data_masking/test_perf_data_masking.py::test_data_masking_encrypt_with_json_blob
	tests/performance/test_high_level_imports.py::test_import_times_ceiling
	tests/performance/test_high_level_imports.py::test_tracer_init
	tests/performance/test_high_level_imports.py::test_metrics_init
	tests/performance/test_high_level_imports.py::test_logger_init
	tests/performance/test_high_level_imports.py::test_parser_init
	tests/functional/metrics/datadog/test_metrics_datadog.py::test_datadog_disable_write_to_log_with_env_variable
	tests/performance/parser/test_parser_performance.py::test_parser_with_cache
	tests/performance/test_metrics.py::test_metrics_large_operation_without_json_serialization_sla
	tests/performance/test_metrics.py::test_metrics_large_operation_and_json_serialization_sla
)

python_prepare_all() {
	# disable intergation test
	rm -rf tests/e2e/ \
		tests/unit/idempotency/ \
		tests/integration/ || die "rm failed"

	distutils-r1_python_prepare_all
}

pkg_postinst() {
	optfeature "support for parser" dev-python/pydantic
	optfeature "support of validation" dev-python/fastjsonschema
	optfeature "support for tracer" dev-python/aws-xray-sdk-python
	optfeature "support for redis" dev-python/redis
	optfeature "support for aws-sdk" dev-python/boto3
	optfeature "support for datamasking" dev-python/aws-encryption-sdk dev-python/jsonpath-ng
}
