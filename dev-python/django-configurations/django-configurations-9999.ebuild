# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/jazzband/${PN}.git"
DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6..8} )

inherit distutils-r1 git-r3

DESCRIPTION="A helper for organizing Django project settings"
HOMEPAGE="https://github.com/jazzband/django-configurations"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""
RESTRICT="test"

DEPEND="dev-python/six[${PYTHON_USEDEP}]"
RDEPEND="dev-python/django[${PYTHON_USEDEP}]"

distutils_enable_tests unittest
