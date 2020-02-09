# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )
EGIT_REPO_URI="https://github.com/selwin/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="A library to identify devices by parsing user agent strings"
HOMEPAGE="https://github.com/selwin/python-user-agents"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-python/ua-parser[${PYTHON_USEDEP}]"

python_test() {
	"${PYTHON}" -m unittest discover -v || die "tests failed with ${EPYTHON}"
}
