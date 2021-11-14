# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/python/typeshed.git"
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 git-r3

DESCRIPTION="Collection of library stubs for Python, with static types"
HOMEPAGE="https://github.com/python/typeshed"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
