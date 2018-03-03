# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit git-r3 distutils-r1

DESCRIPTION="Python Library for Tom's Obvious, Minimal Language"
HOMEPAGE="https://github.com/uiri/toml https://pypi.python.org/pypi/toml"
EGIT_REPO_URI="https://github.com/uiri/${PN}.git"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
