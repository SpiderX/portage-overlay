# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
EGIT_REPO_URI="https://github.com/Mimino666/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Language detection library ported from Google"
HOMEPAGE="https://github.com/Mimino666/langdetect"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"

distutils_enable_tests unittest
