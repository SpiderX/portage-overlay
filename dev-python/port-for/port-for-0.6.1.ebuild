# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="An utility and python library for TCP ports management"
HOMEPAGE="https://github.com/kmike/port-for"
SRC_URI="https://github.com/kmike/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/urllib3[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	# Remove coverage
	sed -i '/addopts/s|--cov src/port_for --cov tests ||' setup.cfg \
		|| die "sed failed for setup.cfg"

	distutils-r1_python_prepare_all
}
