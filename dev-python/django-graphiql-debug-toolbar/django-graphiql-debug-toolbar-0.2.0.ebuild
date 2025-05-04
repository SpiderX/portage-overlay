# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Django Debug Toolbar for GraphiQL IDE"
HOMEPAGE="https://github.com/flavors/django-graphiql-debug-toolbar"
SRC_URI="https://github.com/flavors/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # do not launch

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/django-debug-toolbar[${PYTHON_USEDEP}]
	dev-python/graphene-django[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}/${PN}"-0.2.0-compat.patch )

distutils_enable_tests pytest
