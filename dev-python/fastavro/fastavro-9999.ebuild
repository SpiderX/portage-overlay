# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="Fast Avro for Python"
HOMEPAGE="https://github.com/fastavro/fastavro"
EGIT_REPO_URI="https://github.com/fastavro/${PN}.git"

LICENSE="MIT"
SLOT="0"

BDEPEND="dev-python/cython[${PYTHON_USEDEP}]
	test? ( dev-python/cramjam[${PYTHON_USEDEP}]
		dev-python/lz4[${PYTHON_USEDEP}]
		dev-python/zlib-ng[${PYTHON_USEDEP}]
		dev-python/zstandard[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AttributeError
	tests/test_fastavro.py::test_cython_python
)

pkg_postinst() {
	optfeature "interation with codecs" dev-python/cramjam dev-python/lz4 dev-python/zstandard
}
