# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/containerbuildsystem/${PN}.git"
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1 git-r3

DESCRIPTION="Python library for parsing Dockerfile files"
HOMEPAGE="https://github.com/containerbuildsystem/dockerfile-parse"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
