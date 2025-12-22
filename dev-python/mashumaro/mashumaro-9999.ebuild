# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="Fast and well tested serialization library"
HOMEPAGE="https://github.com/Fatal1ty/mashumaro"
EGIT_REPO_URI="https://github.com/Fatal1ty/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/ciso8601[${PYTHON_USEDEP}]
		dev-python/msgpack[${PYTHON_USEDEP}]
		dev-python/orjson[${PYTHON_USEDEP}]
		dev-python/tomli-w[${PYTHON_USEDEP}]
		dev-python/pendulum[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-mock )
distutils_enable_tests pytest

pkg_postinst() {
	optfeature "integration with msgpack" dev-python/msgpack
	optfeature "integration with orjson" dev-python/orjson
	optfeature "integration with toml" dev-python/tomli-w
	optfeature "integration with yaml" dev-python/pyyaml
}
