# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Crontab module for reading and writing crontab files"
HOMEPAGE="https://gitlab.com/doctormo/python-crontab/"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/python-dateutil[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/cron-descriptor[${PYTHON_USEDEP}]
		dev-python/croniter[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest

python_prepare_all() {
	# Disable failing test
	sed -i  -e "/test_07_non_posix_shell/a\\        raise unittest.SkipTest('test fails')" \
		tests/test_compatibility.py || die "sed failed for test_compatibility.py"

	distutils-r1_python_prepare_all
}

pkg_postinst() {
	optfeature "integration with croniter" dev-python/croniter
	optfeature "integration with cron descriptor" dev-python/cron-descriptor
}
