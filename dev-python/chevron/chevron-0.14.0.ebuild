# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} python3_13t )

inherit distutils-r1 pypi

DESCRIPTION="Mustache templating language renderer"
HOMEPAGE="https://github.com/noahmorrison/chevron"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
