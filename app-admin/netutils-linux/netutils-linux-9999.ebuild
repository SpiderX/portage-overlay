# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Suite of network stack performance tunning utilities"
HOMEPAGE="https://github.com/strizhechenko/netutils-linux"
EGIT_REPO_URI="https://github.com/strizhechenko/netutils-linux.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/configargparse[${PYTHON_USEDEP}]
	dev-python/prettytable[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"

distutils_enable_tests unittest

src_prepare() {
	default

	# Rename due collision with net-analyzer/net-snmp
	mv utils/snmptop utils/snmp-top || die "snmptop rename failed"
	# Rename due collision with sys-apps/util-linux
	mv utils/irqtop utils/irq-top || die "irqtop rename failed"
	sed -i  -e '/snmptop/s/snmptop/snmp-top/' \
		-e '/irqtop/s/irqtop/irq-top/' tests/utils_runnable \
		|| die "sed for utils_runnable failed"
	sed -i  -e '/snmptop/s/snmptop/snmp-top/' \
		-e '/irqtop/s/irqtop/irq-top/' README.rst \
		|| die "sed for README.rst failed"
}

python_test() {
	# Run only tests not affected by #659348
	"${EPYTHON}" -m unittest discover -v netutils_linux_monitoring/ \
		|| die "tests failed with ${EPYTHON}"
	"${EPYTHON}" -m unittest discover -v netutils_linux_tuning/ \
		|| die "tests failed with ${EPYTHON}"
}
