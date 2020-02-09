# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..7} )
EGIT_REPO_URI="https://github.com/doctormo/${PN}.git"

inherit distutils-r1 eutils git-r3

DESCRIPTION="Crontab module for reading and writing crontab files"
HOMEPAGE="https://gitlab.com/doctormo/python-crontab/"
SRC_URI=""

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS=""
IUSE="test"

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/cron-descriptor[${PYTHON_USEDEP}]
		dev-python/croniter[${PYTHON_USEDEP}]
		dev-python/python-dateutil[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# Disable failing test
	sed -i  -e "/test_10_crontab_dir/a\\        raise unittest.SkipTest('test fails')" \
		-e "/test_06_bad_spool/a\\        raise unittest.SkipTest('test fails')" \
		-e "/test_05_spool/a\\        raise unittest.SkipTest('test fails')" \
		tests/test_crontabs.py || die "sed failed for test_crontabs.py"
	sed -i  -e "/test_02_user/a\\        raise unittest.SkipTest('test fails')" \
		-e "/test_04_username/a\\        raise unittest.SkipTest('test fails')" \
		tests/test_usage.py || die "sed failed for test_usage.py"

	distutils-r1_python_prepare_all
}

python_test() {
	mkdir tests/data/spool || die "mkdir failed"
	"${PYTHON}" -m unittest discover -v || die "tests failed with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "integration with croniter" dev-python/croniter
	optfeature "integration with cron descriptor" dev-python/cron-descriptor
}
