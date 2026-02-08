# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Programmatic startup/shutdown of ASGI apps"
HOMEPAGE="https://github.com/florimondmanca/asgi-lifespan"
EGIT_REPO_URI="https://github.com/florimondmanca/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/sniffio[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/httpx[${PYTHON_USEDEP}]
		dev-python/starlette[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-trio[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}/${PN}"-2.1.0-test-asgi.patch
	"${FILESDIR}/${PN}"-2.1.0-tests-trio.patch
	"${FILESDIR}/${PN}"-2.1.0-tests-eg.patch
	"${FILESDIR}/${PN}"-2.1.0-test-trio.patch )

distutils_enable_tests pytest

src_prepare() {
	default

	# remove coverage
	sed -i '/addopts/,+5d' setup.cfg || die "sed failed"
}
