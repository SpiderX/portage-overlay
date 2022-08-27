# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )
EGIT_REPO_URI="https://github.com/architest/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Library of astronomical algorithms in Python"
HOMEPAGE="https://github.com/architest/pymeeus"
SRC_URI=""

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS=""

distutils_enable_tests pytest
