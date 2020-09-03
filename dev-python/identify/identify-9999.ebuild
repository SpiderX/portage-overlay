# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6..8} )
EGIT_REPO_URI="https://github.com/chriskuehl/${PN}.git"

inherit distutils-r1 eutils git-r3

DESCRIPTION="File identification library for Python"
HOMEPAGE="https://github.com/chriskuehl/identify"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

BDEPEND="test? ( dev-python/editdistance[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "license" dev-python/editdistance
}
