# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )

MY_PN="python-${PN}"
MY_P="${MY_PN}-${PV}"

inherit distutils-r1

DESCRIPTION="A fast and complete Python implementation of Markdown"
HOMEPAGE="https://github.com/trentm/python-markdown2"
SRC_URI="https://github.com/trentm/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/pygments[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	# Remove sdist bdist_wheel
	sed -i '1,3d' setup.cfg || die "sed failed for setup.cfg"

	distutils-r1_python_prepare_all
}

src_test() {
	emake test
}
