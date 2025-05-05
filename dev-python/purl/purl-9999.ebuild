# Copyright 1999-2028 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Simple Python URL class"
HOMEPAGE="https://github.com/codeinthehole/purl"
EGIT_REPO_URI="https://github.com/codeinthehole/${PN}.git"

LICENSE="MIT"
SLOT="0"

distutils_enable_tests pytest
