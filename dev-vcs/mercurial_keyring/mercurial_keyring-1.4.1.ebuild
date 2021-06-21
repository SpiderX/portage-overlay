# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Mercurial Keyring Extension"
HOMEPAGE="https://foss.heptapod.net/mercurial/mercurial_keyring"
SRC_URI="https://foss.heptapod.net/mercurial/${PN}/-/archive/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"

RDEPEND="dev-python/keyring[${PYTHON_USEDEP}]
	dev-vcs/mercurial-extension_utils[${PYTHON_USEDEP}]"

DOCS=( {HISTORY,README}.rst )

distutils_enable_tests unittest
