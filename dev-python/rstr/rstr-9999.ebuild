# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=pyproject.toml
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/leapfrogonline/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Generate random strings in Python"
HOMEPAGE="https://pypi.org/project/rstr/"
SRC_URI=""

LICENSE="BSD"
SLOT=0
KEYWORDS=""

distutils_enable_tests unittest
