# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Windows LNK File Parser and Creator"
HOMEPAGE="https://github.com/strayge/pylnk"
EGIT_REPO_URI="https://github.com/strayge/pylnk.git"

LICENSE="LGPL-3+"
SLOT="0"

distutils_enable_tests pytest
