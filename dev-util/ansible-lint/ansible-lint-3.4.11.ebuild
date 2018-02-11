# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_5} )

inherit distutils-r1

DESCRIPTION="Best practices checker for Ansible"
HOMEPAGE="https://github.com/willthames/${PN} https://pypi.python.org/pypi/${PN}"
SRC_URI="https://github.com/willthames/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="app-admin/ansible[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
