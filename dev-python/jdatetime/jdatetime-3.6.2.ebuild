# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

MY_PN="python-jalali"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Jalali implementation of Python's datetime module"
HOMEPAGE="https://github.com/slashmili/python-jalali"
SRC_URI="https://github.com/slashmili/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="PYTHON"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${MY_P}"

DOCS=( CHANGELOG.md README.rst )

python_prepare_all() {
	# Disable tests require fr_FR.UTF-8 locale
	sed -i '/test_with_fa_locale/i\\    @unittest.skip("disable")' \
		t/test.py || die "sed failed for test.py"

	distutils-r1_python_prepare_all
}

python_test() {
	"${PYTHON}" -m unittest discover -v t || die "tests failed with ${EPYTHON}"
}
