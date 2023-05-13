# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,10} )

inherit distutils-r1

DESCRIPTION="Wrapper for Ansible CLI"
HOMEPAGE="https://gitlab.com/vstconsulting/polemarch-ansible"
SRC_URI="https://gitlab.com/vstconsulting/${PN}/-/archive/${PV}/${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-admin/ansible[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]"

distutils_enable_tests unittest
