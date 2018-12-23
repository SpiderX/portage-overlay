# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

MY_P="ruamel.ordereddict-${PV}"

inherit distutils-r1

DESCRIPTION="An ordered dictionary with KIO/KVIO"
HOMEPAGE="https://bitbucket.org/ruamel/ordereddict"
SRC_URI="mirror://pypi/r/ruamel.ordereddict/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

S="${WORKDIR}/${MY_P}"

# Remove files without tests and one failed test, remove namespaces
PATCHES=( "${FILESDIR}"/"${P}"-test.patch )

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_test() {
	py.test -v || die "tests failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -name '*.pth' -delete || die "removing of *.pth failed"
}
