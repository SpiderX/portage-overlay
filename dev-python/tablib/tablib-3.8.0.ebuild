# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Format-agnostic tabular dataset library"
HOMEPAGE="https://github.com/jazzband/tablib"
SRC_URI="https://github.com/jazzband/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cli ods pandas xls xlsx yaml"
REQUIRED_USE="test? ( cli ods pandas xls xlsx yaml )"

RDEPEND="cli? ( dev-python/tabulate[${PYTHON_USEDEP}] )
	ods? ( dev-python/odfpy[${PYTHON_USEDEP}] )
	pandas? ( dev-python/pandas[${PYTHON_USEDEP}] )
	xls? ( dev-python/xlrd[${PYTHON_USEDEP}]
		dev-python/xlwt[${PYTHON_USEDEP}] )
	xlsx? ( dev-python/openpyxl[${PYTHON_USEDEP}] )
	yaml? ( dev-python/pyyaml[${PYTHON_USEDEP}] )"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_prepare_all() {
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"

	# disable pytest options
	sed -i '/addopts/d' pytest.ini || die "sed failed for pytest.ini"

	distutils-r1_python_prepare_all
}
