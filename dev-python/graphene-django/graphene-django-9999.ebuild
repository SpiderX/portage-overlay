# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/graphql-python/${PN}.git"

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="A Django integration for Graphene"
HOMEPAGE="https://github.com/graphql-python/graphene-django"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
RESTRICT="test" # fails

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/graphene[${PYTHON_USEDEP}]
	dev-python/graphql-core[${PYTHON_USEDEP}]
	dev-python/promise[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/text-unidecode[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/django-filter[${PYTHON_USEDEP}]
		dev-python/djangorestframework[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pytest-django[${PYTHON_USEDEP}]
		dev-python/pytest-random-order[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	sed -i '/pytest-runner/d' setup.py || die "sed failed"

	distutils-r1_python_prepare_all
}

pkg_postinst() {
	optfeature "integration with Django REST Framework" dev-python/djangorestframework
}
