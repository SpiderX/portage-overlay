# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
PYTHON_REQ_USE="threads(+)"
EGIT_COMMIT="6fa1012960499c9bee6cf59756c3df736f1c6cdf" # before cv2

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="Video editing with Python"
HOMEPAGE="https://github.com/Zulko/moviepy"
EGIT_REPO_URI="https://github.com/Zulko/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/decorator[${PYTHON_USEDEP}]
	dev-python/imageio[${PYTHON_USEDEP}]
	dev-python/imageio-ffmpeg[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pillow[truetype,${PYTHON_USEDEP}]
	dev-python/proglog[${PYTHON_USEDEP}]
	dev-python/python-dotenv[${PYTHON_USEDEP}]"
BDEPEND="test? ( media-gfx/imagemagick
		media-video/ffmpeg[lame,vorbis,vpx,x264] )"

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "support incorporate texts" media-gfx/imagemagick
	optfeature "support video and sound previews" dev-python/pygame
	optfeature "support resize video clips" dev-python/scipy
	optfeature "support advanced image manipulation" dev-python/scikit-image
	optfeature "support plotting" dev-python/matplotlib
}
