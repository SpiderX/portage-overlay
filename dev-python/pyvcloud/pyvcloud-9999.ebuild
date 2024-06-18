# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
EGIT_REPO_URI="https://github.com/vmware/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="VMware vCloud Director Python SDK"
HOMEPAGE="https://github.com/vmware/pyvcloud"

LICENSE="Apache-2.0"
SLOT="0"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/humanfriendly[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/vcd-api-schemas-type[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/pygments[${PYTHON_USEDEP}]
		dev-python/unittest-xml-reporting[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest

python_test() {
	pushd tests || die "pushd failed"
	./run-tests.sh "${PYTHON}" -m unittest discover -v test || die "tests failed with ${EPYTHON}"
	popd || die "popd failed"
}

python_install_all() {
	distutils-r1_python_install_all
	# Don't install license
	find "${ED}" -type f -name "open_source_license_pyvCloud_20.0.0_GA.txt" -exec rm -rv {} + \
		|| die "test removing failed"
}
