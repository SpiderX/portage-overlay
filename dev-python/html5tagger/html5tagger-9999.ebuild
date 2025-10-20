# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Pythonic HTML generation/templating"
HOMEPAGE="https://github.com/sanic-org/html5tagger"
EGIT_REPO_URI="https://github.com/sanic-org/${PN}.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"
