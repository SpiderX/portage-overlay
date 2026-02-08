# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="A suite of Python utilities for AWS Lambda functions"
HOMEPAGE="https://github.com/aws-powertools/powertools-lambda-python"
EGIT_REPO_URI="https://github.com/awslabs/aws-lambda-powertools-python.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/avro[${PYTHON_USEDEP}]
		dev-python/aws-encryption-sdk[${PYTHON_USEDEP}]
		dev-python/aws-xray-sdk[${PYTHON_USEDEP}]
		dev-python/boto3[${PYTHON_USEDEP}]
		dev-python/jsonpath-ng[${PYTHON_USEDEP}]
		dev-python/multiprocess[${PYTHON_USEDEP}]
		dev-python/pydantic[${PYTHON_USEDEP}]
		dev-python/pydantic-settings[${PYTHON_USEDEP}]
		dev-python/redis[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-{asyncio,mock,socket} )
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

EPYTEST_IGNORE=( tests/{e2e,unit/idempotency,integration} )

pkg_postinst() {
	optfeature "support for parser" dev-python/pydantic
	optfeature "support of validation" dev-python/fastjsonschema
	optfeature "support for tracer" dev-python/aws-xray-sdk-python
	optfeature "support for redis" dev-python/redis
	optfeature "support for aws-sdk" dev-python/boto3
	optfeature "support for avro" dev-python/avro
	optfeature "support for datamasking" dev-python/aws-encryption-sdk dev-python/jsonpath-ng
}
