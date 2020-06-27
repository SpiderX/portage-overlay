# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..7} )
EGIT_REPO_URI="https://github.com/jieter/${PN}.git"

inherit distutils-r1 eutils git-r3

DESCRIPTION="Django application for creating HTML tables"
HOMEPAGE="https://github.com/jieter/django-tables2"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
BDEPEND="test? ( $(python_gen_impl_dep sqlite)
		dev-python/django-filter[${PYTHON_USEDEP}]
		dev-python/fudge[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
		dev-python/openpyxl[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/psycopg:2[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/tablib[${PYTHON_USEDEP}] )"

python_test() {
	PYTHONPATH=. django-admin.py test --settings=tests.app.settings \
		tests --verbosity 2 || die "tests failed with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "integration with Tablib for exporting table data as CSV, XLS" dev-python/tablib
	optfeature "integration with PostgreSQL backend for Automatic rendering of data in jsoncolumn" dev-python/psycopg:2
}
