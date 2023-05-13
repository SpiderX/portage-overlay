# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,10} )
EGIT_REPO_URI="https://gitlab.com/vstconsulting/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Wrapper for Ansible CLI"
HOMEPAGE="https://gitlab.com/vstconsulting/polemarch-ansible"
SRC_URI=""

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""

RDEPEND="app-admin/ansible[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]"

distutils_enable_tests unittest
