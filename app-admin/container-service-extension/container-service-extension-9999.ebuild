# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
EGIT_REPO_URI="https://github.com/vmware/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Container Service Extension for vCloud Director"
HOMEPAGE="https://github.com/vmware/container-service-extension"

LICENSE="BSD-2"
SLOT="0"
RESTRICT="test" # fails

RDEPEND=">=app-admin/vcd-cli-24.0.0[${PYTHON_USEDEP}]
	dev-python/cachetools[${PYTHON_USEDEP}]
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
	# Don't install license and notice
	sed -i '/data_files/,+2d' setup.py \
		|| die "sed failed for setup.py"

	# Relax requirement
	sed -i '/pyvmomi/s/6.7.0 , < //' requirements.txt \
		|| die "sed failed for requirements.txt"

	distutils-r1_python_prepare_all
}
