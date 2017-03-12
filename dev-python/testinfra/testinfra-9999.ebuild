# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5} )

inherit git-r3 distutils-r1

DESCRIPTION="An unit tests in Python to test actual state of servers"
HOMEPAGE="https://github.com/philpep/${PN} http://${PN}.readthedocs.io/en/latest/"
EGIT_REPO_URI="https://github.com/philpep/${PN}.git"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pbr[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"
