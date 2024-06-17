# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
EGIT_REPO_URI="https://github.com/Yelp/${PN}.git"
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="An enterprise friendly way of detecting and preventing secrets"
HOMEPAGE="https://github.com/Yelp/detect-secrets"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="!dev-python/bc-detect-secrets[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/ahocorasick[${PYTHON_USEDEP}]
		dev-python/responses[${PYTHON_USEDEP}]
		dev-python/unidiff[${PYTHON_USEDEP}]
		dev-util/gibberish-detector[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# assertion error
	tests/main_test.py::TestScan::test_saves_to_baseline
	tests/audit/audit_test.py::test_make_decisions
	tests/audit/audit_test.py::test_start_halfway
	tests/core/baseline_test.py::TestCreate::test_basic_usage
	tests/core/scan_test.py::TestGetFilesToScan::test_handles_each_path_separately
	tests/core/scan_test.py::TestGetFilesToScan::test_handles_multiple_directories
	# AttributeError: 'TestAWSKeyDetector' object has no attribute 'example_key'
	tests/plugins/aws_key_test.py::TestAWSKeyDetector::test_verify_no_secret
	tests/plugins/aws_key_test.py::TestAWSKeyDetector::test_verify_valid_secret
	tests/plugins/aws_key_test.py::TestAWSKeyDetector::test_verify_invalid_secret
	tests/plugins/aws_key_test.py::TestAWSKeyDetector::test_verify_keep_trying_until_found_something
	# AttributeError: 'TestAnalyzeLine' object has no attribute 'filename'
	tests/plugins/base_test.py::TestAnalyzeLine::test_potential_secret_constructed_correctly
	tests/plugins/base_test.py::TestAnalyzeLine::test_no_verification_call_if_verification_filter_is_disabled
	tests/plugins/base_test.py::TestAnalyzeLine::test_handle_verify_exception_gracefully
)

python_prepare_all() {
	if use test ; then
		git init > /dev/null || die "git init failed"
		git config --global user.email "${PN}@gentoo.org" || die "git config failed"
		git config --global user.name "${PN}" || die "git config failed"
	fi
	distutils-r1_python_prepare_all
}

pkg_postinst() {
	optfeature "integration with Aho-Corasick search" dev-python/ahocorasick
	optfeature "integration with gibberish detector" dev-util/gibberish-detector
}
