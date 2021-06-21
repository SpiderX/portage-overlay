# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/wroberts/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="A library to parse time from human readable string"
HOMEPAGE="https://github.com/wroberts/pytimeparse"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

distutils_enable_tests unittest

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}
