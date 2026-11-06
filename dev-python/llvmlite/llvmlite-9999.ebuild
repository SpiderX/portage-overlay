# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} python3_{13..15}t )
LLVM_COMPAT=( {19..24} )

inherit cmake distutils-r1 git-r3 llvm-r2

DESCRIPTION="A lightweight wrapper around basic LLVM functionality"
HOMEPAGE="https://github.com/numba/llvmlite"
EGIT_REPO_URI="https://github.com/numba/${PN}.git"

LICENSE="BSD"
SLOT="0"

RDEPEND="dev-libs/libffi:=
	dev-libs/icu:=
	dev-libs/libxml2:2
	sys-libs/ncurses:=[tinfo]
	virtual/zlib:=
	$(llvm_gen_dep 'llvm-core/clang:${LLVM_SLOT}= llvm-core/llvm:${LLVM_SLOT}=')"

distutils_enable_tests unittest

python_prepare_all() {
	export LLVMLITE_SHARED=true
	distutils-r1_python_prepare_all
}

python_test() {
	"${EPYTHON}" runtests.py -v || die "tests failed for ${EPYTHON}"
}
