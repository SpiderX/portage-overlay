# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )

inherit distutils-r1

DESCRIPTION="Python library for reading and writing kickstart files"
HOMEPAGE="https://github.com/pykickstart/pykickstart"
SRC_URI="https://github.com/pykickstart/${PN}/archive/r${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="vim-syntax"

RDEPEND="dev-python/polib[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	vim-syntax? ( || ( app-editors/vim app-editors/gvim ) )"

S="${WORKDIR}/${PN}-r${PV}"

distutils_enable_tests unittest

src_test() {
	emake test
}

src_install() {
	distutils-r1_src_install

	if use vim-syntax ; then
		insinto /usr/share/vim/vimfiles
		doins data/kickstart.vim
	fi
}
