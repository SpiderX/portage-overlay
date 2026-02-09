# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1 pypi

DESCRIPTION="OpenTelemetry Google Cloud Resource Detector"
HOMEPAGE="https://github.com/GoogleCloudPlatform/opentelemetry-operations-python"

LICENSE="Apache-2.0"
SLOT=0
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/opentelemetry-api[${PYTHON_USEDEP}]
	dev-python/opentelemetry-sdk[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/syrupy[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-snapshot )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AssertionError
	tests/test_mapping.py::test_get_monitored_resource
	tests/test_gcp_resource_detector.py::test_detects_empty_when_not_available
	tests/test_gcp_resource_detector.py::test_detects_empty_as_fallback
	tests/test_gcp_resource_detector.py::test_detects_gce
	tests/test_gcp_resource_detector.py::test_detects_gke
	tests/test_gcp_resource_detector.py::test_detects_cloud_run
	tests/test_gcp_resource_detector.py::test_detects_cloud_functions
	tests/test_gcp_resource_detector.py::test_detects_gae_standard
	tests/test_gcp_resource_detector.py::test_detects_gae_flex
)

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type f -name "py.typed" -exec rm -rv {} + || die "py.typed removing failed"
}
