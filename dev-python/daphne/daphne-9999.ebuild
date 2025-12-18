# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Django ASGI (HTTP/WebSocket) server"
HOMEPAGE="https://github.com/django/daphne"
EGIT_REPO_URI="https://github.com/django/${PN}.git"

LICENSE="BSD"
SLOT="0"

RDEPEND="dev-python/asgiref[${PYTHON_USEDEP}]
	dev-python/autobahn[${PYTHON_USEDEP}]
	dev-python/twisted[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/hypothesis[${PYTHON_USEDEP}] )"

export ASGI_THREADS=4

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest
