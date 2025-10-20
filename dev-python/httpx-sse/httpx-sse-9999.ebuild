# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Consume Server-Sent Event (SSE) messages with HTTPX"
HOMEPAGE="https://github.com/florimondmanca/httpx-sse"
EGIT_REPO_URI="https://github.com/florimondmanca/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/httpx[${PYTHON_USEDEP}]
	dev-python/starlette[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? ( dev-python/sse-starlette[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest

src_prepare() {
	default

	# remove coverage
	sed -i '/addopts/,+5d' setup.cfg || die "sed failed"
}
