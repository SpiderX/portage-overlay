# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

MY_PN="${PN/-/_}"
MY_P="${MY_PN}-${PV}"
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Mercurial Extension Utils"
HOMEPAGE="https://bitbucket.org/Mekk/mercurial-extension_utils"
SRC_URI="mirror://pypi/m/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"

DOCS=( README.txt )
