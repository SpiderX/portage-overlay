# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )
EGIT_REPO_URI="https://github.com/kmike/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="An utility and python library for TCP ports management"
HOMEPAGE="https://github.com/kmike/port-for"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="test? ( dev-python/urllib3[${PYTHON_USEDEP}]
		virtual/python-unittest-mock[${PYTHON_USEDEP}] )"

src_prepare() {
	default

	sed -i '/import urllib2/s/urllib2/urllib/' port_for/_download_ranges.py \
		|| die "sed failed for _download_ranges.py"
}

python_test() {
	"${EPYTHON}" setup.py test || die "tests failed"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${D}" -name 'tests.*' -delete || die "tests removing failed"
}
