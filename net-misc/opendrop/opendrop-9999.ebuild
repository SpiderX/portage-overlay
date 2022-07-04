# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )
EGIT_REPO_URI="https://github.com/seemoo-lab/opendrop.git"

inherit distutils-r1 git-r3

DESCRIPTION="an Open Source AirDrop Implementation"
HOMEPAGE="https://github.com/seemoo-lab/opendrop"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/fleep[${PYTHON_USEDEP}]
	dev-python/ifaddr[${PYTHON_USEDEP}]
	dev-python/libarchive-c[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/requests-toolbelt[${PYTHON_USEDEP}]
	dev-python/zeroconf[${PYTHON_USEDEP}]"
