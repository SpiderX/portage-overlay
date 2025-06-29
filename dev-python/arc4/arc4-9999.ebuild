# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="A small and insanely fast ARCFOUR (RC4) cipher"
HOMEPAGE="https://github.com/manicmaniac/arc4"
EGIT_REPO_URI="https://github.com/manicmaniac/${PN}.git"

LICENSE="MIT"
SLOT="0"

distutils_enable_tests pytest
