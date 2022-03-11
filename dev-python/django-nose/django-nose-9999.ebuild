# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/jazzband/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Django test runner using nose"
HOMEPAGE="https://github.com/jazzband/django-nose"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
RESTRICT="test" # fails

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/dj-database-url[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

distutils_enable_tests nose

python_test() {
	./runtests.sh || die "tests failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "testapp" -exec rm -rv {} + || die "test removing failed"
}
