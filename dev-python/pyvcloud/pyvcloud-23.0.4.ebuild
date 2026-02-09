# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1 edo

DESCRIPTION="VMware vCloud Director Python SDK"
HOMEPAGE="https://github.com/vmware/pyvcloud"
SRC_URI="https://github.com/vmware/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no DNS RR anymore
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

python_prepare_all() {
	# pbr is unable to detect version
	echo -e "Name: ${PN}\nVersion: ${PV}" > PKG-INFO \
		|| die "echo failed for PKG-INFO"

	distutils-r1_python_prepare_all
}

python_test() {
	edo pushd tests
	edo ./run-tests.sh "${PYTHON}" -m unittest discover -v test
	edo popd
}

python_install_all() {
	distutils-r1_python_install_all
	# don't install license
	find "${ED}" -type f -name "open_source_license_pyvCloud_20.0.0_GA.txt" -exec rm -rv {} + \
		|| die "test removing failed"
}
