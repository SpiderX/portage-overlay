# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 optfeature

MY_PN="detect-secrets"

DESCRIPTION="A fork of enterprise friendly way of detecting and preventing secrets"
HOMEPAGE="https://github.com/bridgecrewio/detect-secrets"
SRC_URI="https://github.com/bridgecrewio/${MY_PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="!dev-util/detect-secrets[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/unidiff[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/ahocorasick[${PYTHON_USEDEP}]
		dev-python/responses[${PYTHON_USEDEP}]
		dev-util/gibberish-detector[${PYTHON_USEDEP}]
		dev-vcs/git )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# assertion error
	tests/main_test.py::TestScan::test_saves_to_baseline
	tests/audit/audit_test.py::test_make_decisions
	tests/audit/audit_test.py::test_start_halfway
	tests/core/baseline_test.py::TestCreate::test_basic_usage
	tests/core/scan_test.py::TestGetFilesToScan::test_handles_each_path_separately
	tests/core/scan_test.py::TestGetFilesToScan::test_handles_multiple_directories
	test_diff/test_diff.py::TestDiff::test_scan_secret_diff
	test_diff/test_diff.py::TestDiff::test_scan_secret_diff_add_or_remove
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
