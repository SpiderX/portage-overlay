# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_OPTIONAL=1
PYTHON_COMPAT=( python3_{8..11} )
EGIT_REPO_URI="https://github.com/facebookresearch/${PN}.git"

inherit cmake distutils-r1 git-r3

DESCRIPTION="Library for fast text representation and classification"
HOMEPAGE="https://github.com/facebookresearch/fastText"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="python"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

CDEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
RDEPEND="python? ( ${PYTHON_DEPS}
		${CDEPEND} )"
DEPEND="python? ( ${CDEPEND} )"
BDEPEND="python? ( dev-python/pybind11[${PYTHON_USEDEP}] )"

src_prepare() {
	cmake_src_prepare
	use python && distutils-r1_src_prepare

	sed -i  -e "/CMAKE_CXX_FLAGS/d" \
		-e "s/\(DESTINATION\) lib/\1 $(get_libdir)/g" \
		CMakeLists.txt || die "sed failed for CMakeLists.txt"
	sed -i "/extra_compile_args=/,+1d" setup.py \
		|| die "sed failed for setup.py"
}

python_prepare_all() {
	# fix QA
	sed -i '/description/s/-/_/' setup.cfg || die "sed failed for setup.cfg"
	distutils-r1_python_prepare_all
}

src_configure() {
	cmake_src_configure
	use python && distutils-r1_src_configure
}

src_compile() {
	cmake_src_compile
	use python && distutils-r1_src_compile
}

src_test() {
	use python && distutils-r1_src_test
}

python_test() {
	"${EPYTHON}" runtests.py -u || die "test fails"
}

src_install() {
	cmake_src_install
	use python && distutils-r1_src_install

	find "${ED}" -name '*.a' -delete || die "find failed"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + \
		|| die "test removing failed"
}
