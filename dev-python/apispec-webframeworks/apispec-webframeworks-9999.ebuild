# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/marshmallow-code/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Web framework plugins for apispec"
HOMEPAGE="https://github.com/marshmallow-code/apispec-webframeworks"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/apispec[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/bottle[${PYTHON_USEDEP}]
		dev-python/flask[${PYTHON_USEDEP}]
		www-servers/tornado[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}
