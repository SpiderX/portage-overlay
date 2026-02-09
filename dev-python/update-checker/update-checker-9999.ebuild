# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="A python module that will check for package updates"
HOMEPAGE="https://github.com/bboe/update_checker"
EGIT_REPO_URI="https://github.com/bboe/${PN}.git"

LICENSE="BSD-2"
SLOT="0"

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
