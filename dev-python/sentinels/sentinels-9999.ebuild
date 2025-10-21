# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Various objects to denote special meanings in python"
HOMEPAGE="https://github.com/vmalloc/sentinels"
EGIT_REPO_URI="https://github.com/vmalloc/${PN}.git"

LICENSE="BSD"
SLOT="0"

distutils_enable_tests pytest
