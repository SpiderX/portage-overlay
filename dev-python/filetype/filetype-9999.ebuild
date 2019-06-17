# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5..7}} )
EGIT_REPO_URI="https://github.com/h2non/${PN}.py.git"

inherit distutils-r1 git-r3

DESCRIPTION="Infer file type and MIME type of any file/buffer"
HOMEPAGE="https://github.com/h2non/filetype.py"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_prepare_all() {
	# Do not install examples
	sed -i "/packages=find_packages/s/ts'/ts', 'examples'/" setup.py \
		|| die "sed for setup.py failed"

	distutils-r1_python_prepare_all
}

python_test() {
	"${PYTHON}" -m unittest discover -v || die "tests failed with ${EPYTHON}"
}
