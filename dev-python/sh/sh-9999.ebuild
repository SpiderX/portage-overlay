# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} pypy3 )
EGIT_REPO_URI="https://github.com/amoffat/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Python subprocess interface"
HOMEPAGE="https://github.com/amoffat/shellingham"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

distutils_enable_tests unittest

python_prepare_all() {
	# Disable test
	sed -i '/test_timeout/i\\    @unittest.skip("disable")' \
		test.py || die "sed failed for test.py"

	distutils-r1_python_prepare_all
}
