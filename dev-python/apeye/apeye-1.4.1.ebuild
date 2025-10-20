# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 optfeature

DESCRIPTION="Handy tools for working with URLs and APIs"
HOMEPAGE="https://github.com/domdfcoding/apeye"
SRC_URI="https://github.com/domdfcoding/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/apeye-core[${PYTHON_USEDEP}]
	dev-python/domdf-python-tools[${PYTHON_USEDEP}]
	dev-python/platformdirs[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/cachecontrol[${PYTHON_USEDEP}]
		dev-python/cherrypy[${PYTHON_USEDEP}]
		dev-python/coincidence[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}/${PN}"-1.4.1-tests.patch )

EPYTEST_PLUGINS=( pytest-{datadir,httpserver} )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# ValueError: no option named 'with_test_class_names'
	tests/test_email_validator.py::test_email_valid
	# AssertionError
	tests/test_url.py::TestSlumberURL::test_options
)

pkg_postinst() {
	optfeature "integration with limiter" dev-python/cachecontrol
}
