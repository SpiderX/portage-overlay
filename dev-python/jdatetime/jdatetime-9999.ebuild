# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{6..8} )
EGIT_REPO_URI="https://github.com/slashmili/python-jalali.git"

inherit distutils-r1 git-r3

DESCRIPTION="Jalali implementation of Python's datetime module"
HOMEPAGE="https://github.com/slashmili/python-jalali"
SRC_URI=""

LICENSE="PYTHON"
SLOT="0"
KEYWORDS=""
IUSE=""

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
