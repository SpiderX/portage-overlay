# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5..6}} )
EHG_REPO_URI="https://bitbucket.org/Mekk/mercurial_keyring"
MY_PN="${PN/-/_}"
MY_P="${MY_PN}-${PV}"

inherit distutils-r1 mercurial

DESCRIPTION="Mercurial Keyring Extension"
HOMEPAGE="https://bitbucket.org/Mekk/mercurial_keyring"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/keyring[${PYTHON_USEDEP}]
	dev-vcs/mercurial-extension_utils[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"
