# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 mercurial

DESCRIPTION="Mercurial Keyring Extension"
HOMEPAGE="https://foss.heptapod.net/mercurial/mercurial_keyring"
EHG_REPO_URI="https://foss.heptapod.net/mercurial/mercurial_keyring"

LICENSE="BSD"
SLOT="0"
RESTRICT="test" # fails

RDEPEND="dev-python/keyring[${PYTHON_USEDEP}]
	dev-vcs/mercurial-extension_utils[${PYTHON_USEDEP}]"

DOCS=( {HISTORY,README}.rst )

distutils_enable_tests unittest
