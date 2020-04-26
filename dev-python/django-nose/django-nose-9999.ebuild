# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6..8} )
EGIT_REPO_URI="https://github.com/jazzband/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Django test runner using nose"
HOMEPAGE="https://github.com/jazzband/django-nose"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="test" #https://github.com/jazzband/django-nose/issues/76

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/dj-database-url[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/nose[${PYTHON_USEDEP}]"

python_test() {
	./runtests.sh || die "tests failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "testapp" -exec rm -rv {} + || die "test removing failed"
}
