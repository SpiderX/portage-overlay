# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="The Official Api Spec Language for Dropbox"
HOMEPAGE="https://github.com/dropbox/stone"
SRC_URI="https://github.com/dropbox/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/ply[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
