# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

MY_PN="python-${PN}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Java Property file parser and writer for Python"
HOMEPAGE="https://github.com/Tblue/python-jproperties"
SRC_URI="https://github.com/Tblue/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/pytest-datadir[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# TypeError: 'PosixPath' object is not subscriptable
	tests/test_simple_utf8.py::test_simple_utf8_load_write_file
)

python_prepare_all() {
	rm pytest.ini || die "rm failed"

	# setuptools is unable to detect version
	sed -i  -e "/setup(/a\\    version=\"${PV}\"," \
		-e "/use_scm_version/d" \
		-e "/setuptools_scm/d" \
		setup.py || die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}
