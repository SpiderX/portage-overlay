# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..12} )
EGIT_REPO_URI="https://github.com/clarete/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Patch python built-in objects"
HOMEPAGE="https://github.com/clarete/forbiddenfruit"

LICENSE="LGPL-3 MIT"
SLOT="0"

RESTRICT="test" # nose
