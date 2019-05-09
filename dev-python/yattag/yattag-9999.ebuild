# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5..7}} )
EGIT_REPO_URI="https://github.com/leforestier/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Generate HTML or XML in a pythonic way"
HOMEPAGE="http://www.yattag.org https://github.com/leforestier/yattag"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	"${PYTHON}" -m unittest discover -v test || die "tests failed with ${EPYTHON}"
}
