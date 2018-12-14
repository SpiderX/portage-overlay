# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..7}} )
EGIT_REPO_URI="https://github.com/joke2k/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="An environment variables to configure Django"
HOMEPAGE="https://github.com/joke2k/django-environ"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	"${PYTHON}" -m unittest discover -v || die "tests failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -name 'test*' -delete || die "tests removing failed"
}
