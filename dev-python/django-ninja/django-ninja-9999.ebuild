# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Fast Django REST Framework"
HOMEPAGE="https://github.com/vitalik/django-ninja"
EGIT_REPO_URI="https://github.com/vitalik/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/pydantic[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=( pytest-{asyncio,django} )
distutils_enable_tests pytest
