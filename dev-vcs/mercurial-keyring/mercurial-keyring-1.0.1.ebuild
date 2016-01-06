# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_3 python3_4 )
inherit distutils-r1

MY_PN="${PN/-/_}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Mercurial Keyring Extension"
HOMEPAGE="http://bitbucket.org/Mekk/mercurial_keyring"
SRC_URI="http://pypi.python.org/packages/source/m/${MY_PN}/${MY_P}.tar.gz"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DOCS=( README.txt HISTORY.txt )
DEPEND="dev-python/setuptools"
RDEPEND="dev-python/keyring
	dev-vcs/mercurial-extension_utils"
S="${WORKDIR}/${MY_P}"
