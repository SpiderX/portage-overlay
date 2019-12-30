# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5..8}} )
EGIT_REPO_URI="https://github.com/strizhechenko/netutils-linux.git"

inherit distutils-r1 git-r3

DESCRIPTION="Suite of network stack performance tunning utilities"
HOMEPAGE="https://github.com/strizhechenko/netutils-linux"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
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

src_prepare() {
	default

	# Rename due collision with net-analyzer/net-snmp
	mv utils/snmptop utils/snmp-top || die "snmptop rename failed"
	sed -i '/snmptop/s/snmptop/snmp-top/' tests/utils_runnable \
		|| die "sed for utils_runnable failed"
	sed -i '/snmptop/s/snmptop/snmp-top/' README.rst \
		|| die "sed for README.rst failed"
}

python_test() {
	# Run only tests not affected by #659348
	"${EPYTHON}" -m unittest discover -v netutils_linux_monitoring/ \
		|| die "tests failed with ${EPYTHON}"
	"${EPYTHON}" -m unittest discover -v netutils_linux_tuning/ \
		|| die "tests failed with ${EPYTHON}"
}
