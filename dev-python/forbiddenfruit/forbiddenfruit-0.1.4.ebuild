# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Patch python built-in objects"
HOMEPAGE="https://github.com/clarete/forbiddenfruit"

LICENSE="LGPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="test" # nose
