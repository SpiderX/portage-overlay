# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )
PYTHON_REQ_USE="sqlite"

inherit distutils-r1 optfeature

DESCRIPTION="Terminal spreadsheet multitool for discovering and arranging data"
HOMEPAGE="https://github.com/saulpw/visidata"
SRC_URI="https://github.com/saulpw/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/importlib-metadata[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/h5py[${PYTHON_USEDEP}]
		dev-python/odfpy[${PYTHON_USEDEP}]
		dev-python/openpyxl[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-vcs/git )"

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
	#optfeature "integration with pcap" dev-python/dnslib #dpkt
	#optfeature "integration with pdf" pdfminer.six tabula
	#optfeature "integration with mbtiles" mapbox-vector-tile
	#optfeature "integration with xpt (SAS)" xport
	#optfeature "integration with sas7bdat (SAS)" sas7bdat
	#optfeature "integration with sav (SPSS)" savReaderWriter
	#optfeature "integration with datapackage" frictionless .json
	#optfeature "integration with vcf" vobject
}
