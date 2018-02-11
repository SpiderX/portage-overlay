# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_5} )

inherit git-r3 distutils-r1

DESCRIPTION="Best practices checker for Ansible"
HOMEPAGE="https://github.com/willthames/${PN} https://pypi.python.org/pypi/${PN}"
EGIT_REPO_URI="https://github.com/willthames/${PN}.git"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

CDEPEND="app-admin/ansible[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
