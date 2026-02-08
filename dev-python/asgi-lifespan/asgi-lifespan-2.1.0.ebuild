# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Programmatic startup/shutdown of ASGI apps"
HOMEPAGE="https://github.com/florimondmanca/asgi-lifespan"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/sniffio[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/httpx[${PYTHON_USEDEP}]
		dev-python/starlette[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}/${PN}"-2.1.0-test-asgi.patch
	"${FILESDIR}/${PN}"-2.1.0-tests-trio.patch
	"${FILESDIR}/${PN}"-2.1.0-tests-eg.patch
	"${FILESDIR}/${PN}"-2.1.0-test-trio.patch )

EPYTEST_PLUGINS=( pytest-{asyncio,trio} )
distutils_enable_tests pytest

src_prepare() {
	default

	# remove coverage
	sed -i '/addopts/,+5d' setup.cfg || die "sed failed"
}
