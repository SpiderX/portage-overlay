# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5..7}} pypy pypy3 )

inherit distutils-r1

DESCRIPTION="plugin for adding to the PYTHONPATH from command line or configs"
HOMEPAGE="https://pypi.org/project/pytest-pythonpath
	https://github.com/bigsassy/pytest-pythonpath"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""
RESTRICT="test"

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
