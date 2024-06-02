# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..12} )
EGIT_REPO_URI="https://github.com/mhalshehri/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Hijri-Gregorian date converter"
HOMEPAGE="https://github.com/mhalshehri/hijri-converter"

LICENSE="MIT"
SLOT="0"

BDEPEND="dev-python/hatch-fancy-pypi-readme[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
