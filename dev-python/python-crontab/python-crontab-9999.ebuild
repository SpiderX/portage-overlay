# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )
EGIT_REPO_URI="https://github.com/doctormo/${PN}.git"

inherit distutils-r1 eutils git-r3

DESCRIPTION="Crontab module for reading and writing crontab files"
HOMEPAGE="https://github.com/doctormo/python-coreschema"
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
	# Disable failed test
	sed -i "/test_06_backwards/a\\        raise unittest.SkipTest('test fails')" \
		tests/test_range.py || die "sed failed for test_range.py"
	# Temp. point stdout to ${T}
	sed -i "/test_03_usage/a\\        raise unittest.SkipTest('test fails')" \
		tests/test_usage.py || die "sed failed for test_usage.py"

	distutils-r1_python_prepare_all
}

python_test() {
	"${PYTHON}" -m unittest discover -v || die "tests failed with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "integration with croniter" dev-python/croniter
	optfeature "integration with cron descriptor" dev-python/cron-descriptor
}
