# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/jazzband/${PN}.git"

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="Format-agnostic tabular dataset library"
HOMEPAGE="https://github.com/jazzband/tablib"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="xls yaml"

RDEPEND="xls? ( dev-python/xlrd[${PYTHON_USEDEP}]
		dev-python/xlwt[${PYTHON_USEDEP}] )
	yaml? ( dev-python/pyyaml[${PYTHON_USEDEP}] )"
BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]
	test? ( dev-python/MarkupPy[${PYTHON_USEDEP}]
		dev-python/odfpy[${PYTHON_USEDEP}]
		dev-python/openpyxl[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/tabulate[${PYTHON_USEDEP}]
		dev-python/xlrd[${PYTHON_USEDEP}]
		dev-python/xlwt[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	# Disable pytest options
	sed -i '/addopts/d' pytest.ini || die "sed failed for pytest.ini"

	distutils-r1_python_prepare_all
}

pkg_postinst() {
	optfeature "support cli" dev-python/tabulate
	optfeature "support html" dev-python/MarkupPy
	optfeature "support ods" dev-python/odfpy
	optfeature "support pandas" dev-python/pandas
	optfeature "support xls" dev-python/xlrd dev-python/xlwt
	optfeature "support xlsx" dev-python/openpyxl
	optfeature "support yaml" dev-python/pyyaml
}
