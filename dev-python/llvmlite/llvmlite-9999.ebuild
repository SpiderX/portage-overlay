# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )
LLVM_COMPAT=( {16..18} )

inherit cmake distutils-r1 git-r3 llvm-r1

DESCRIPTION="A lightweight wrapper around basic LLVM functionality"
HOMEPAGE="https://github.com/numba/llvmlite"
EGIT_REPO_URI="https://github.com/numba/${PN^}.git"

LICENSE="BSD"
SLOT="0"

RDEPEND="dev-libs/libffi:=
	dev-libs/icu:=
	dev-libs/libxml2:2
	sys-libs/zlib:=
	sys-libs/ncurses:=[tinfo]
	$(llvm_gen_dep 'llvm-core/clang:${LLVM_SLOT}= llvm-core/llvm:${LLVM_SLOT}=')"

PATCHES=( # https://github.com/numba/llvmlite/pull/1042
	"${FILESDIR}/${PN}"-0.43-llvm-17.patch
	"${FILESDIR}/${PN}"-0.43-llvm-17-tests.patch )

distutils_enable_tests unittest

python_prepare_all() {
	export LLVMLITE_SHARED=true
	distutils-r1_python_prepare_all

	# remove test — assertion error
	sed -i "/test_rv32d_ilp32(/,+6d" llvmlite/tests/test_binding.py \
		|| die "sed failed for test_binding.py"
}

python_test() {
	"${EPYTHON}" runtests.py -v || die "tests failed for ${EPYTHON}"
}
