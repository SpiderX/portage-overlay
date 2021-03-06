# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7,8,9} pypy3 )
DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1

DESCRIPTION="Python wrapper for extended filesystem attributes"
HOMEPAGE="https://github.com/xattr/xattr"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/cffi-1.1.0:=[${PYTHON_USEDEP}]
	' 'python*')
"
