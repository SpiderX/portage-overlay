# Copyright 1999-2018 Gentoo Authors
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

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	virtual/python-futures[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-django[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# Remove unneeded requirement
	sed -i 's:setup_requires:_&:' setup.py || die "sed failed for setup.py"
	distutils-r1_python_prepare_all
}

python_test() {
	emake test
}
