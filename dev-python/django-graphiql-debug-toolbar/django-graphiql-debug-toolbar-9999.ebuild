# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/flavors/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Django Debug Toolbar for GraphiQL IDE"
HOMEPAGE="https://github.com/flavors/django-graphiql-debug-toolbar"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
RESTRICT="test" # fails

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/django-debug-toolbar[${PYTHON_USEDEP}]
	dev-python/graphene-django[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
