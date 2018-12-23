# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
EHG_REPO_URI="https://bitbucket.org/ruamel/ordereddict"

inherit distutils-r1 mercurial

DESCRIPTION="An ordered dictionary with KIO/KVIO"
HOMEPAGE="https://bitbucket.org/ruamel/ordereddict"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

# Remove files without tests and one failed test, remove namespace
PATCHES=( "${FILESDIR}"/"${PN}"-0.4.13-test.patch
	"${FILESDIR}"/"${P}"-unittest.patch )

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_test() {
	py.test -v || die "tests failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -name '*.pth' -delete || die "removing of *.pth failed"
}
