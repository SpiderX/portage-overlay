# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python library for reading and writing kickstart files"
HOMEPAGE="https://github.com/pykickstart/pykickstart"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="vim-syntax"

RDEPEND="dev-python/polib[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	vim-syntax? ( || ( app-editors/vim app-editors/gvim ) )"

distutils_enable_tests unittest

src_test() {
	emake test-no-coverage
}

src_install() {
	distutils-r1_src_install

	if use vim-syntax ; then
		insinto /usr/share/vim/vimfiles
		doins data/kickstart.vim
	fi
}
