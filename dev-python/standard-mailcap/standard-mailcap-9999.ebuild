# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Standard library mailcap redistribution"
HOMEPAGE="https://github.com/youknowone/python-deadlib"
EGIT_REPO_URI="https://github.com/youknowone/python-deadlib.git"
S="${WORKDIR}/${P}/mailcap"

LICENSE="PSF-2"
SLOT="0"
RESTRICT="test"

distutils_enable_tests pytest
