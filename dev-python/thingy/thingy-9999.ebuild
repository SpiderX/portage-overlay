# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Dictionary as an object, that can have different views"
HOMEPAGE="https://github.com/Refty/thingy"
EGIT_REPO_URI="https://github.com/Refty/${PN}.git"

LICENSE="MIT"
SLOT="0"

distutils_enable_tests pytest

python_prepare_all() {
	# disable pytest options
	sed -i '/addopts/d' setup.cfg || die "sed failed for setup.cfg"

	distutils-r1_python_prepare_all
}
