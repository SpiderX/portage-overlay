# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="OpenTelemetry Google Cloud Resource Detector"
HOMEPAGE="https://github.com/GoogleCloudPlatform/opentelemetry-operations-python"
EGIT_REPO_URI="https://github.com/GoogleCloudPlatform/opentelemetry-operations-python.git"
S="${WORKDIR}/${P}/${PN}"

LICENSE="Apache-2.0"
SLOT=0

RDEPEND="dev-python/opentelemetry-api[${PYTHON_USEDEP}]
	dev-python/opentelemetry-sdk[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/syrupy[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-snapshot )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AssertionError
	tests/test_detector.py::test_detects_empty_when_not_available
	tests/test_detector.py::test_detects_empty_as_fallback
	tests/test_detector.py::test_detects_gce
	tests/test_detector.py::test_detects_gke
	tests/test_detector.py::test_detects_cloud_run
	tests/test_detector.py::test_detects_cloud_functions
	tests/test_detector.py::test_detects_gae_standard
	tests/test_detector.py::test_detects_gae_flex
	tests/test_mapping.py::test_get_monitored_resource
)
