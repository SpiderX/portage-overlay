# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
EGIT_REPO_URI="https://github.com/openai/openai-python.git"
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 git-r3

DESCRIPTION="The official Python library for the OpenAI API"
HOMEPAGE="https://github.com/openai/openai-python"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-python/anyio[${PYTHON_USEDEP}]
	dev-python/distro[${PYTHON_USEDEP}]
	dev-python/httpx[${PYTHON_USEDEP}]
	dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/sniffio[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/dirty-equals[${PYTHON_USEDEP}]
		dev-python/respx[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}] )"
#dev-python/respx[${PYTHON_USEDEP}] doesn't have python3_10, used in removed tests

EPYTEST_XDIST=1
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# openai.OpenAIError: The api_key client option must be set
	tests/lib/test_old_api.py::test_basic_attribute_access_works
	# AssertionError
	tests/test_client.py::TestOpenAI::test_copy_build_request
	tests/test_client.py::TestAsyncOpenAI::test_copy_build_request
)

src_prepare() {
	default

	# remove tests need mock server
	rm -rf tests/api_resources || die "rm failed"
}
