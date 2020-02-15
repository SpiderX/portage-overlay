# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6..7} )
EGIT_REPO_URI="https://gitlab.com/vstconsulting/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Wrapper for Ansible CLI"
HOMEPAGE="https://gitlab.com/vstconsulting/polemarch-ansible"
SRC_URI=""

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="app-admin/ansible[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]"

python_test() {
	"${PYTHON}" -m unittest discover -v || die "tests failed with ${EPYTHON}"
}
