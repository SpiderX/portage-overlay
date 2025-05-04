# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="A library to identify devices by parsing user agent strings"
HOMEPAGE="https://github.com/selwin/python-user-agents"
EGIT_REPO_URI="https://github.com/selwin/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/ua-parser[${PYTHON_USEDEP}]"

distutils_enable_tests unittest
