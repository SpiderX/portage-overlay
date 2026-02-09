# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Human-readable HTML tracebacks for Python exceptions"
HOMEPAGE="https://github.com/sanic-org/tracerite"
EGIT_REPO_URI="https://github.com/sanic-org/${PN}.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-python/html5tagger[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"
