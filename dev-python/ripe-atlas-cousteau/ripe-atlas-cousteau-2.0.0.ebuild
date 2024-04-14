# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_PN="${PN//-/.}"
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{9..12} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Official python wrapper around RIPE Atlas API"
HOMEPAGE="https://github.com/RIPE-NCC/ripe-atlas-cousteau"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/websocket-client[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/jsonschema[${PYTHON_USEDEP}] )"

DOCS=( {CHANGES,README}.rst )

distutils_enable_sphinx docs
distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all
	rm -rf "ripe/__pycache__" "ripe/atlas/__pycache__" || die
}

pkg_postinst() {
	optfeature "fast json processing" dev-python/ujson
}
