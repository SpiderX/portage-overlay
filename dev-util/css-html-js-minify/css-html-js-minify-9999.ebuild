# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/juancarlospaco/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="StandAlone Async cross-platform Minifier for the Web"
HOMEPAGE="https://github.com/juancarlospaco/css-html-js-minify"
SRC_URI=""

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""

distutils_enable_tests unittest

python_test() {
	"${PYTHON}" -m unittest discover -v tests || die "tests failed with ${EPYTHON}"
}
