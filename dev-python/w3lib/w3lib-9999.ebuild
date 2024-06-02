# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
EGIT_REPO_URI="https://github.com/scrapy/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Library of web-related functions"
HOMEPAGE="https://github.com/scrapy/w3lib"

LICENSE="BSD"
SLOT="0"

distutils_enable_tests pytest
