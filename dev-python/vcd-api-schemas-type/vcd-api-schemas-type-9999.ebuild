# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6..8} )
EGIT_REPO_URI="https://github.com/core-api/python-client.git"

inherit distutils-r1 git-r3

DESCRIPTION="VMware vCloud Director Python API Schemas Type"
HOMEPAGE="https://github.com/vmware/vcd-api-schemas"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

BDEPEND="dev-python/pbr[${PYTHON_USEDEP}]"
