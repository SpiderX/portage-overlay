# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5..8}} )

inherit distutils-r1

DESCRIPTION="Suite of network stack performance tunning utilities"
HOMEPAGE="https://github.com/strizhechenko/netutils-linux"
SRC_URI="https://github.com/strizhechenko/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/configargparse[${PYTHON_USEDEP}]
	dev-python/prettytable[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	virtual/python-ipaddress[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	# Run only tests not affected by #659348
	"${EPYTHON}" -m unittest discover -v netutils_linux_monitoring/ \
		|| die "tests failed with ${EPYTHON}"
	"${EPYTHON}" -m unittest discover -v netutils_linux_tuning/ \
		|| die "tests failed with ${EPYTHON}"
}

src_test() {
	distutils-r1_src_test
	# Run only tests not affected by #659348
	./tests/utils_runnable || die "utils tests failed"
	./tests/rss-ladder-test || die "rss tests failed"
	./tests/link_rate_units.sh || die "link rate tests failed"
}
