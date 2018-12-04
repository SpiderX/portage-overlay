# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

inherit distutils-r1

DESCRIPTION="Simple library for dealing with subprocesses"
HOMEPAGE="https://github.com/kennethreitz/delegator.py"
SRC_URI="https://github.com/kennethreitz/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/pexpect[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"
