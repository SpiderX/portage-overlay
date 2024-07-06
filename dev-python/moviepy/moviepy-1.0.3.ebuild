# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Video editing with Python"
HOMEPAGE="https://github.com/Zulko/moviepy"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="dev-python/decorator[${PYTHON_USEDEP}]
	dev-python/imageio[${PYTHON_USEDEP}]
	dev-python/imageio-ffmpeg[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/proglog[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "support incorporate texts" media-gfx/imagemagick
	optfeature "support video and sound previews" dev-python/pygame
	optfeature "support advanced image processing" dev-python/pillow
	optfeature "support resize video clips" dev-python/scipy
	optfeature "support advanced image manipulation" dev-python/scikit-image
	optfeature "support plotting" dev-python/matplotlib
}
