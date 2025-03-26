# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Utilities for Google Media Downloads and Resumable Uploads"
HOMEPAGE="https://github.com/googleapis/google-resumable-media-python"
EGIT_REPO_URI="https://github.com/googleapis/google-resumable-media-python.git"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="test"

RDEPEND="dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/google-crc32c[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/google-cloud-testutils[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	#needs GOOGLE_APPLICATION_CREDENTIALS
	tests/system/requests/test_download.py::TestDownload::test_download_full
	tests/system/requests/test_download.py::TestDownload::test_download_to_stream
	tests/system/requests/test_download.py::TestDownload::test_extra_headers
	tests/system/requests/test_download.py::TestDownload::test_non_existent_file
	tests/system/requests/test_download.py::TestDownload::test_bad_range
	tests/system/requests/test_download.py::TestDownload::test_download_partial
	tests/system/requests/test_download.py::TestRawDownload::test_download_full
	tests/system/requests/test_download.py::TestRawDownload::test_download_to_stream
	tests/system/requests/test_download.py::TestRawDownload::test_extra_headers
	tests/system/requests/test_download.py::TestRawDownload::test_non_existent_file
	tests/system/requests/test_download.py::TestRawDownload::test_bad_range
	tests/system/requests/test_download.py::TestRawDownload::test_download_partial
	tests/system/requests/test_download.py::TestRawDownload::test_corrupt_download
	tests/system/requests/test_download.py::TestChunkedDownload::test_chunked_download_partial
	tests/system/requests/test_download.py::TestChunkedDownload::test_chunked_with_extra_headers
	tests/system/requests/test_download.py::TestRawChunkedDownload::test_chunked_download_partial
	tests/system/requests/test_download.py::TestRawChunkedDownload::test_chunked_with_extra_headers
	tests/system/requests/test_download.py::TestRawChunkedDownload::test_chunked_download_full
	tests/system/requests/test_upload.py::test_simple_upload
	tests/system/requests/test_upload.py::test_simple_upload_with_headers
	tests/system/requests/test_upload.py::test_multipart_upload
	tests/system/requests/test_upload.py::test_multipart_upload_with_bad_checksum
	tests/system/requests/test_upload.py::test_multipart_upload_with_headers
	tests/system/requests/test_upload.py::test_resumable_upload
	tests/system/requests/test_upload.py::test_resumable_upload_with_headers
	tests/system/requests/test_upload.py::test_resumable_upload_with_bad_checksum
	tests/system/requests/test_upload.py::test_resumable_upload_bad_chunk_size
	tests/system/requests/test_upload.py::test_resumable_upload_recover
	tests/system/requests/test_upload.py::test_resumable_upload_recover_with_headers
	tests/system/requests/test_upload.py::TestResumableUploadUnknownSize::test_smaller_than_chunk_size
	tests/system/requests/test_upload.py::TestResumableUploadUnknownSize::test_finish_at_chunk
	tests/system/requests/test_upload.py::TestResumableUploadUnknownSize::test_interleave_writes
	tests/system/requests/test_download.py::TestDownload::test_download_gzip_w_stored_content_headers
	tests/system/requests/test_download.py::TestRawDownload::test_download_gzip_w_stored_content_headers
	tests/system/requests/test_upload.py::test_XMLMPU
	tests/system/requests/test_upload.py::test_XMLMPU_with_bad_checksum
	tests/system/requests/test_upload.py::test_XMLMPU_cancel
	tests/system/requests/test_download.py::TestDownload::test_download_brotli_w_stored_content_headers
	tests/system/requests/test_download.py::TestRawDownload::test_download_brotli_w_stored_content_headers
)

python_compile() {
	distutils-r1_python_compile
	find "${BUILD_DIR}" -name '*.pth' -delete || die "find failed"
}

src_test() {
	rm -r google || die "rm failed"
	distutils-r1_src_test
}

python_test() {
	distutils_write_namespace google
	epytest -v tests || die "tests failed with ${EPYTHON}"
}
