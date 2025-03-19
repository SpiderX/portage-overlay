# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..13} )
EGIT_REPO_URI="https://github.com/openai/openai-python.git"

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="The official Python library for the OpenAI API"
HOMEPAGE="https://github.com/openai/openai-python"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="datalib test"

RDEPEND="dev-python/anyio[${PYTHON_USEDEP}]
	dev-python/distro[${PYTHON_USEDEP}]
	dev-python/httpx[${PYTHON_USEDEP}]
	dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/sniffio[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	datalib? ( dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/pandas-stubs[${PYTHON_USEDEP}] )"
BDEPEND="test? ( dev-python/dirty-equals[${PYTHON_USEDEP}]
		dev-python/inline-snapshot[${PYTHON_USEDEP}]
		dev-python/nest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/respx[${PYTHON_USEDEP}]
		dev-python/rich[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AssertionError
	tests/test_client.py::TestAsyncOpenAI::test_copy_build_request
	tests/test_client.py::TestOpenAI::test_copy_build_request
)
EPYTEST_IGNORE=(
	# requires npm mock server
	tests/api_resources
)

pkg_postinst() {
	optfeature "support realtime" dev-python/websockets
}
