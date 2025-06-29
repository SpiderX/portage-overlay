# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

MY_PN="NfsClient"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python library to simulate NFS client"
HOMEPAGE="https://github.com/Pennyw0rth/NfsClient"
SRC_URI="https://github.com/Pennyw0rth/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.gh.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests
