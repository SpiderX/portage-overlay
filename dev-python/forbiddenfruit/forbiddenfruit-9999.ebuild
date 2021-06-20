# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/clarete/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Patch python built-in objects"
HOMEPAGE="https://github.com/clarete/forbiddenfruit"
SRC_URI=""

LICENSE="LGPL-3 MIT"
SLOT="0"
KEYWORDS=""
RESTRICT="test" # fails

distutils_enable_tests nose
