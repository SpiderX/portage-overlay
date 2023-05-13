# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,10} )

inherit distutils-r1

MY_PV="${PV/_pre/.dev}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="VMware vCloud Director Python API Schemas Type"
HOMEPAGE="https://github.com/vmware/vcd-api-schemas"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="dev-python/pbr[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"
