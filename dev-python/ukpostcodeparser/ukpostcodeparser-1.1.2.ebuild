# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="UK postcode parser library"
HOMEPAGE="https://github.com/hamstah/ukpostcodeparser"
SRC_URI="https://github.com/hamstah/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# https://github.com/hamstah/ukpostcodeparser/issues/8
PATCHES=( "${FILESDIR}/${PN}"-1.1.2-test.patch )

distutils_enable_tests unittest

python_test() {
	"${PYTHON}" -m unittest discover -v -s ukpostcodeparser/test \
		-p parser.py || die "tests failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "test" -exec rm -rv {} + || die "tests removing failed"
}
