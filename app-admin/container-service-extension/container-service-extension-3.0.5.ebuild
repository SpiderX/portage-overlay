# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Container Service Extension for vCloud Director"
HOMEPAGE="https://github.com/vmware/container-service-extension"
SRC_URI="https://github.com/vmware/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # fails
RDEPEND="dev-python/cachetools[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/humanfriendly[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	>=dev-python/pika-0.13.0[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-4.2[${PYTHON_USEDEP}]
	>=dev-python/pyvcloud-22.0.1[${PYTHON_USEDEP}]
	>=dev-python/pyvmomi-6.7.0[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/semantic-version[${PYTHON_USEDEP}]
	>=dev-python/vcd-api-schemas-type-9.1.2_pre10[${PYTHON_USEDEP}]
	>=dev-python/vsphere-guest-run-0.0.7[${PYTHON_USEDEP}]"
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
