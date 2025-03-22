# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11} )

inherit distutils-r1 git-r3

DESCRIPTION="Container Service Extension for vCloud Director"
HOMEPAGE="https://github.com/vmware/container-service-extension"
EGIT_REPO_URI="https://github.com/vmware/${PN}.git"

LICENSE="BSD-2"
SLOT="0"
RESTRICT="test" # fails

RDEPEND="app-admin/vcd-cli[${PYTHON_USEDEP}]
	dev-python/cachetools[${PYTHON_USEDEP}]
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
	# Don't install license and notice
	sed -i '/data_files/,+2d' setup.py \
		|| die "sed failed for setup.py"

	# Relax requirement
	sed -i '/pyvmomi/s/ , < 7.0.0//' requirements.txt \
		|| die "sed failed for requirements.txt"

	distutils-r1_python_prepare_all
}
