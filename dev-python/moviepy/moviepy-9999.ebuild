# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
PYTHON_REQ_USE="threads(+)"
EGIT_REPO_URI="https://github.com/Zulko/${PN}.git"

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="Video editing with Python"
HOMEPAGE="https://github.com/Zulko/moviepy"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/decorator[${PYTHON_USEDEP}]
	dev-python/imageio[${PYTHON_USEDEP}]
	dev-python/imageio-ffmpeg[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/proglog[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]"
BDEPEND="test? ( media-gfx/imagemagick[postscript]
		media-video/ffmpeg[mp3,vorbis,vpx] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	tests/test_ffmpeg_reader.py::test_ffmpeg_parse_infos_decode_file # assert 29.99 == 30.02
	tests/test_ffmpeg_reader.py::test_ffmpeg_parse_video_rotation # KeyError: 'video_rotation'
	tests/test_ffmpeg_reader.py::test_correct_video_rotation # assert [1920, 1080] == [1080, 1920]
	tests/test_ffmpeg_tools.py::test_ffmpeg_resize # Failed: DID NOT RAISE <class 'OSError'>
	tests/test_ffmpeg_tools.py::test_ffmpeg_stabilize_video # Failed: DID NOT RAISE <class 'OSError'>
	tests/test_PR.py::test_PR_306 # AssertionError: assert [] != []
	tests/test_fx.py::test_rotate # ValueError
	tests/test_PR.py::test_PR_529 # assert 0 == 180
	tests/test_TextClip.py::test_list # IndexError: list index out of range
	tests/test_TextClip.py::test_search # FileNotFoundError
	tests/test_VideoClip.py::test_write_frame_errors # AssertionError
	tests/test_VideoClip.py::test_write_frame_errors_with_redirected_logs # assert
)

pkg_postinst() {
	optfeature "support incorporate texts" media-gfx/imagemagick
	optfeature "support video and sound previews" dev-python/pygame
	optfeature "support advanced image processing" dev-python/pillow
	optfeature "support resize video clips" dev-python/scipy
	optfeature "support advanced image manipulation" dev-python/scikit-image
	optfeature "support plotting" dev-python/matplotlib
}
