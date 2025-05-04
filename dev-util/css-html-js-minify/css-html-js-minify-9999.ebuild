# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="StandAlone Async cross-platform Minifier for the Web"
HOMEPAGE="https://github.com/juancarlospaco/css-html-js-minify"
EGIT_REPO_URI="https://github.com/juancarlospaco/${PN}.git"

LICENSE="LGPL-3"
SLOT="0"

distutils_enable_tests unittest

python_test() {
	"${PYTHON}" -m unittest discover -v tests || die "tests failed with ${EPYTHON}"
}
