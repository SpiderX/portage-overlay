# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
EHG_REPO_URI="https://foss.heptapod.net/mercurial/mercurial_keyring"

inherit distutils-r1 mercurial

DESCRIPTION="Mercurial Keyring Extension"
HOMEPAGE="https://foss.heptapod.net/mercurial/mercurial_keyring"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
RESTRICT="test"

RDEPEND="dev-python/keyring[${PYTHON_USEDEP}]
	dev-vcs/mercurial-extension_utils[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

DOCS=( {HISTORY,README}.rst )

distutils_enable_tests unittest
