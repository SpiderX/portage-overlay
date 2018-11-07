# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5..6}} )
MY_PN="${PN/-/_}"
MY_P="${MY_PN}-${PV}"

inherit distutils-r1

DESCRIPTION="Mercurial Keyring Extension"
HOMEPAGE="https://bitbucket.org/Mekk/mercurial_keyring"
SRC_URI="mirror://pypi/m/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/keyring[${PYTHON_USEDEP}]
	dev-vcs/mercurial-extension_utils[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"
