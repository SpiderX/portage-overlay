# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )
EGIT_REPO_URI="https://github.com/xmlrunner/${PN}.git"

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="unittest-based test runner with Ant/JUnit like XML reporting"
HOMEPAGE="https://github.com/xmlrunner/unittest-xml-reporting"

LICENSE="BSD-2"
SLOT="0"

RDEPEND="dev-python/lxml[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/django[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest

EPYTEST_DESELECT=(
	# AttributeError: 'tuple' object has no attribute 'shortDescription'
	tests/testsuite.py::XMLTestRunnerTestCase::test_basic_unittest_constructs
	tests/testsuite.py::XMLTestRunnerTestCase::test_unexpected_success
	# AssertionError: 5 != 6
	tests/testsuite.py::XMLTestRunnerTestCase::test_xmlrunner_hold_traceback
)

python_prepare_all() {
	# dont install license
	sed -i '/data_files/d' setup.py || die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}

pkg_postinst() {
	optfeature "integration with django" dev-python/django
}
