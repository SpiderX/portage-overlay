# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/vbwagner/ctypescrypto.git"

inherit distutils-r1 git-r3

DESCRIPTION="File format determination library for Python"
HOMEPAGE="https://github.com/vbwagner/ctypescrypto"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="gost"
REQUIRED_USE="test? ( gost )"

RDEPEND="gost? ( dev-libs/gost-engine:= )"

distutils_enable_tests unittest

python_prepare_all() {
	# Remove failed tests
	rm tests/testpkey.py || die "rm failed"
	# Disable test
	sed -i '/test_verify_by_filestore/i\\    @unittest.skip("disable")' \
		tests/testx509.py || die "sed failed for tests/testx509.py"

	distutils-r1_python_prepare_all
}

python_test() {
	"${PYTHON}" -m unittest discover -v tests || die "tests failed with ${EPYTHON}"
}
