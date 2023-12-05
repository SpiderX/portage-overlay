# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{9..12} )

inherit distutils-r1 pypi

DESCRIPTION="Microsoft Azure Client Common Library for Python"
HOMEPAGE="https://github.com/Azure/azure-python-devtools"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}" "${PV}" .zip)"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

BDEPEND="app-arch/unzip"

DOCS=( {CHANGELOG,README}.md )
