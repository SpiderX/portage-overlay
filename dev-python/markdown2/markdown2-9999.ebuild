# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )
EGIT_REPO_URI="https://github.com/trentm/python-markdown2.git"

inherit distutils-r1 git-r3

DESCRIPTION="A fast and complete Python implementation of Markdown"
HOMEPAGE="https://github.com/trentm/python-markdown2"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-python/pygments[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_prepare_all() {
	# Remove sdist bdist_wheel
	sed -i '1,3d' setup.cfg || die "sed failed for setup.cfg"

	distutils-r1_python_prepare_all
}

src_test() {
	emake test
}
