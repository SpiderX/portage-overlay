# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} python3_13t )

inherit distutils-r1 git-r3

DESCRIPTION="Library of astronomical algorithms in Python"
HOMEPAGE="https://github.com/architest/pymeeus"
EGIT_REPO_URI="https://github.com/architest/${PN}.git"

LICENSE="GPL-3 LGPL-3"
SLOT="0"

distutils_enable_tests pytest
