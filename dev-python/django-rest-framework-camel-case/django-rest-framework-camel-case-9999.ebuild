# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )
EGIT_REPO_URI="https://github.com/vbabiy/djangorestframework-camel-case.git"

inherit distutils-r1 git-r3

DESCRIPTION="Camel case JSON support for Django REST framework"
HOMEPAGE="https://github.com/vbabiy/djangorestframework-camel-case"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/django-rest-framework[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

python_test() {
	emake test
}
