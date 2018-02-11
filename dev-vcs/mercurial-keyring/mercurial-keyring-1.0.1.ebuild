# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

MY_PN="${PN/-/_}"
MY_P="${MY_PN}-${PV}"
PYTHON_COMPAT=( python2_7 python3_3 python3_4 )

inherit distutils-r1

DESCRIPTION="Mercurial Keyring Extension"
HOMEPAGE="http://bitbucket.org/Mekk/mercurial_keyring"
SRC_URI="mirror://pypi/m/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="dev-python/keyring[${PYTHON_USEDEP}]
	dev-vcs/mercurial-extension_utils[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"

DOCS=( README.txt HISTORY.txt )
