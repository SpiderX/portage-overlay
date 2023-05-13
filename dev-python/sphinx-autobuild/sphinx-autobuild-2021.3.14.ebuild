# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{8,10} )

inherit distutils-r1

DESCRIPTION="Autorebuild documentation on change"
HOMEPAGE="https://github.com/GaretJax/sphinx-autobuild"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/livereload[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
