# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="VMware vCloud Director Python API Schemas Type"
HOMEPAGE="https://github.com/vmware/vcd-api-schemas"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="dev-python/pbr[${PYTHON_USEDEP}]"

src_prepare() {
	default

	sed -i '/import os/,+23d' setup.py || die "sed failed"
}
