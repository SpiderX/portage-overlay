# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Provides the inclusion of the contents of other Markdown documents"
HOMEPAGE="https://github.com/cmacmackin/markdown-include"
SRC_URI="https://github.com/cmacmackin/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="dev-python/markdown[${PYTHON_USEDEP}]"
