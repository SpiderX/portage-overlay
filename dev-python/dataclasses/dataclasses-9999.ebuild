# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_6 )
EGIT_REPO_URI="https://github.com/ericvsmith/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="A backport of the dataclasses module for Python 3.6"
HOMEPAGE="https://github.com/ericvsmith/dataclasses"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

python_test() {
	"${PYTHON}" -m unittest discover -v test || die "tests failed with ${EPYTHON}"
}
