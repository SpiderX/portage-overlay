# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )
PYTHON_REQ_USE="sqlite"

inherit distutils-r1 optfeature pypi

DESCRIPTION="Terminal spreadsheet multitool for discovering and arranging data"
HOMEPAGE="https://github.com/saulpw/visidata"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/standard-mailcap[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "integration with yaml" dev-python/pyyaml
	optfeature "integration with png" dev-python/pypng
	optfeature "integration with http" dev-python/requests
	optfeature "integration with postgres" dev-python/psycopg
	optfeature "integration with xlsx" dev-python/openpyxl
	optfeature "integration with xls" dev-python/xlrd dev-python/xlwt
	optfeature "integration with hdf5" dev-python/h5py
	optfeature "integration with ttf/otf" dev-python/fonttools
	optfeature "integration with xml/htm/html" dev-python/lxml
	optfeature "integration with dta (Stata)" dev-python/pandas
	optfeature "integration with shapefiles" sci-libs/pyshp
	optfeature "integration with namestand" dev-python/graphviz
	optfeature "integration with tabulate/wcwidth" dev-python/tabulate dev-python/wcwidth
	optfeature "integration with pdf" app-text/pdfminer
	optfeature "integration with mbtiles" dev-python/mapbox-vector-tile
	optfeature "integration with vcf" dev-python/vobject
	optfeature "integration with rds" dev-python/boto3
	optfeature "integration with shapefiles" sci-libs/pyshp
	optfeature "integration with mbtiles" dev-python/mapbox-vector-tile
	optfeature "integration with zst" dev-python/zstandard
	optfeature "integration with odfpy" dev-python/odfpy
	optfeature "integration with zip over http" dev-python/urllib3
	optfeature "integration with parquet" dev-python/pyarrow
	optfeature "integration with plot" dev-python/seaborn
	optfeature "integration with svg" dev-python/matplotlib
	optfeature "integration with ping" dev-python/sh
	optfeature "integration with procmgr" dev-python/psutil
	optfeature "integration with npy" dev-python/numpy
	optfeature "integration with msgpack" dev-python/msgpack
	optfeature "integration with msgpackz" dev-python/brotlicffi
	optfeature "integration with scraper" dev-python/requests-cache dev-python/beautifulsoup4
	optfeature "integration with fake" dev-python/faker
}
