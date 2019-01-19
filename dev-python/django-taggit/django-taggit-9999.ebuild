# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )
EGIT_REPO_URI="https://github.com/alex/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Django application for simple tagging"
HOMEPAGE="https://github.com/alex/django-taggit"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( $(python_gen_impl_dep sqlite)
		virtual/python-unittest-mock[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# Remove unneeded requirement
	sed -i 's:setup_requires:_&:' setup.py || die "sed failed for setup.py"
	distutils-r1_python_prepare_all
}

python_test() {
	PYTHONPATH=. django-admin.py test --settings=tests.settings \
		tests --verbosity 2 || die "tests failed with ${EPYTHON}"
}
