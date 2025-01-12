# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Container Service Extension for vCloud Director"
HOMEPAGE="https://github.com/vmware/container-service-extension"
SRC_URI="https://github.com/vmware/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # fails

RDEPEND="dev-python/cachetools[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/humanfriendly[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/pika[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/pyvcloud[${PYTHON_USEDEP}]
	dev-python/pyvmomi[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/semantic-version[${PYTHON_USEDEP}]
	dev-python/vcd-api-schemas-type[${PYTHON_USEDEP}]
	dev-python/vsphere-guest-run[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest

python_prepare_all() {
	# pbr is unable to detect version
	echo -e "Name: ${PN}\nVersion: ${PV}" > PKG-INFO \
		|| die "echo failed for PKG-INFO"

	# Don't install license and notice
	sed -i '/data_files/,+2d' setup.py \
		|| die "sed failed for setup.py"

	# Relax requirement
	sed -i '/pyvmomi/s/ , < 7.0.0//' requirements.txt \
		|| die "sed failed for requirements.txt"

	distutils-r1_python_prepare_all
}
