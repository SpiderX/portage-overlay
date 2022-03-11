# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/vbabiy/djangorestframework-camel-case.git"

inherit distutils-r1 git-r3

DESCRIPTION="Camel case JSON support for Django REST framework"
HOMEPAGE="https://github.com/vbabiy/djangorestframework-camel-case"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/djangorestframework[${PYTHON_USEDEP}]"

distutils_enable_tests unittest
