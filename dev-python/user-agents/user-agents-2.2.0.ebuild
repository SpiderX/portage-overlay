# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 edo pypi

DESCRIPTION="A library to identify devices by parsing user agent strings"
HOMEPAGE="https://github.com/selwin/python-user-agents"
SRC_URI+="
	test? ( https://raw.githubusercontent.com/selwin/python-user-agents/refs/heads/master/user_agents/devices.json )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/ua-parser[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}/${PN}"-2.2.0-parsers.patch
	"${FILESDIR}/${PN}"-2.2.0-tests.patch )

distutils_enable_tests pytest

EPYTEST_DESELECT=( user_agents/tests.py::test_wrapper )

src_unpack() {
	default

	use test && edo cp "${DISTDIR}"/devices.json "${S}"/user_agents
}

python_test() {
	epytest -v user_agents/tests.py
}
