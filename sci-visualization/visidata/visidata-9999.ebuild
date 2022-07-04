# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/saulpw/${PN}.git"

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="Terminal spreadsheet multitool for discovering and arranging data"
HOMEPAGE="https://github.com/saulpw/visidata"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/python-dateutil[${PYTHON_USEDEP}]
	$(python_gen_impl_dep sqlite)"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/h5py[${PYTHON_USEDEP}]
		dev-python/openpyxl[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_test() {
	git init || die "git init failed"
	git add tests/golden/ || die "git add failed"
	dev/test.sh || die "test failed"
}

pkg_postinst() {
	optfeature "integration with yaml" dev-python/pyyaml
	optfeature "integration with png" dev-python/pypng
	optfeature "integration with http" dev-python/requests
	optfeature "integration with postgres" dev-python/psycopg
	optfeature "integration with xlsx" dev-python/openpyxl
	optfeature "integration with xls" dev-python/xlrd
	optfeature "integration with hdf5" dev-python/h5py
	optfeature "integration with ttf/otf" dev-python/fonttools
	optfeature "integration with xml/htm/html" dev-python/lxml
	optfeature "integration with dta (Stata)" dev-python/pandas
	optfeature "integration with shapefiles" sci-libs/pyshp
	optfeature "integration with namestand" dev-python/graphviz
	optfeature "integration with tabulate/wcwidth" dev-python/tabulate # saver
	#optfeature "integration with pdf" pdfminer.six tabula
	#optfeature "integration with pcap" dev-python/dnslib #dpkt
	#optfeature "integration with mbtiles" mapbox-vector-tile
	#optfeature "integration with xpt (SAS)" xport
	#optfeature "integration with sas7bdat (SAS)" sas7bdat
	#optfeature "integration with sav (SPSS)" savReaderWriter
	#optfeature "integration with datapackage" frictionless .json
	#optfeature "integration with vcf" vobject
}
