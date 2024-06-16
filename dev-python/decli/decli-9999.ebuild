# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..13} )
EGIT_REPO_URI="https://github.com/Woile/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Minimal declarative cli tool"
HOMEPAGE="https://github.com/Woile/decli"

LICENSE="MIT"
SLOT="0"

distutils_enable_tests pytest
