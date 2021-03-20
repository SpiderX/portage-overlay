# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{7..9} )
EGIT_REPO_URI="https://github.com/leforestier/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Generate HTML or XML in a pythonic way"
HOMEPAGE="http://www.yattag.org https://github.com/leforestier/yattag"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""

python_test() {
	"${PYTHON}" -m unittest discover -v test || die "tests failed with ${EPYTHON}"
}
