# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )
EGIT_REPO_URI="https://github.com/django-mptt/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Utilities for implementing Modified Preorder Tree Traversal"
HOMEPAGE="https://github.com/django-mptt/django-mptt"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/django-js-asset[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-django[${PYTHON_USEDEP}] )"

python_test() {
	"${PYTHON}" tests/manage.py test myapp --verbosity 2 || die "tests failed with ${EPYTHON}"
}
