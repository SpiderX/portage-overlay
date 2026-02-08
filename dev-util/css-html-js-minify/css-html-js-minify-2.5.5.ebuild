# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="StandAlone Async cross-platform Minifier for the Web"
HOMEPAGE="https://github.com/juancarlospaco/css-html-js-minify"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}" "${PV}" .zip)"
S="${WORKDIR}/${P}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="app-arch/unzip"
