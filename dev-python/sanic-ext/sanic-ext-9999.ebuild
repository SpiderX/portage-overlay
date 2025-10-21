# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Extend Sanic installation with some core functionality"
HOMEPAGE="https://github.com/sanic-org/sanic-ext"
EGIT_REPO_URI="https://github.com/sanic-org/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/pyyaml[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/sanic-testing[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}/${PN}"-24.12.0-setup.patch )

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# KeyError: 'paths'
	tests/extensions/openapi/test_model_fields.py::test_models
	# AssertionError
	tests/extensions/openapi/test_model_spec.py::test_pydantic_base_model
)
