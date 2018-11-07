# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..7}} )
EHG_REPO_URI="https://bitbucket.org/Mekk/mercurial-extension_utils"
MY_PN="${PN/-/_}"
MY_P="${MY_PN}-${PV}"

inherit distutils-r1 mercurial

DESCRIPTION="Mercurial Extension Utils"
HOMEPAGE="https://bitbucket.org/Mekk/mercurial-extension_utils"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"
