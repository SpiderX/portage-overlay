# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5..7}} )

MY_PN="${PN}.py"
MY_P="${MY_PN}-${PV}"

inherit distutils-r1

DESCRIPTION="Infer file type and MIME type of any file/buffer"
HOMEPAGE="https://github.com/h2non/filetype.py"
SRC_URI="https://github.com/h2non/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	# Do not install examples
	sed -i "/packages=find_packages/s/ts'/ts', 'examples'/" setup.py \
		|| die "sed for setup.py failed"

	distutils-r1_python_prepare_all
}

python_test() {
	"${PYTHON}" -m unittest discover -v || die "tests failed with ${EPYTHON}"
}
