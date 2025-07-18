# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )
PYTHON_REQ_USE="sqlite"

inherit distutils-r1 git-r3

DESCRIPTION="real-time metrics for nginx server (and others)"
HOMEPAGE="https://github.com/ngxtop/ngxtop"
EGIT_REPO_URI="https://github.com/ngxtop/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/docopt[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]"

PATCHES=( # add another log format
	"${FILESDIR}/${PN}"-log-format-main.patch )

distutils_enable_tests pytest
