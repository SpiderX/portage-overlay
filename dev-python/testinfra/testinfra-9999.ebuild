# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit git-r3 distutils-r1

DESCRIPTION="An unit tests in Python to test actual state of servers"
HOMEPAGE="https://github.com/philpep/${PN} http://${PN}.readthedocs.io/en/latest/"
EGIT_REPO_URI="https://github.com/philpep/${PN}.git"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="ansible docker salt ssh"

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/paramiko[${PYTHON_USEDEP}]
	ansible? ( app-admin/ansible )
	docker? ( app-emulation/docker )
	salt? ( app-admin/salt )
	ssh? ( virtual/ssh )"

DEPEND="dev-python/pbr[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"
