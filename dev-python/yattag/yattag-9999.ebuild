# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/leforestier/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Generate HTML or XML in a pythonic way"
HOMEPAGE="https://www.yattag.org https://github.com/leforestier/yattag"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""

distutils_enable_tests unittest

python_test() {
	"${PYTHON}" -m unittest discover -v test || die "tests failed with ${EPYTHON}"
}
