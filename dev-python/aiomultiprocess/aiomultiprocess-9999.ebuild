# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
EGIT_REPO_URI="https://github.com/omnilib/${PN}.git"
PYTHON_COMPAT=( python3_{10..13} python3_13t )

inherit distutils-r1 git-r3

DESCRIPTION="asyncio version of the standard multiprocessing module"
HOMEPAGE="https://github.com/omnilib/aiomultiprocess"

LICENSE="MIT"
SLOT="0"

distutils_enable_tests unittest

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}
