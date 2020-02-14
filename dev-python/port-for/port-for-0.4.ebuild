# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )

inherit distutils-r1

DESCRIPTION="An utility and python library for TCP ports management"
HOMEPAGE="https://github.com/kmike/port-for"
SRC_URI="https://github.com/kmike/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/urllib3[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}] )"

python_prepare_all() {
	sed -i '/import urllib2/s/urllib2/urllib/' port_for/_download_ranges.py \
		|| die "sed failed for _download_ranges.py"

	distutils-r1_python_prepare_all
}

python_test() {
	"${PYTHON}" -m unittest discover -v || die "tests failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${D}" -name 'tests.*' -delete || die "tests removing failed"
}
