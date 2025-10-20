# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature

DESCRIPTION="A Django integration for Graphene"
HOMEPAGE="https://github.com/graphql-python/graphene-django"
SRC_URI="https://github.com/graphql-python/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/graphene[${PYTHON_USEDEP}]
	dev-python/graphql-core[${PYTHON_USEDEP}]
	dev-python/graphql-relay[${PYTHON_USEDEP}]
	dev-python/promise[${PYTHON_USEDEP}]
	dev-python/text-unidecode[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/django-filter[${PYTHON_USEDEP}]
		dev-python/djangorestframework[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-{django,random-order} )
distutils_enable_tests pytest

python_prepare_all() {
	# disable pytest-runner
	sed -i '/pytest-runner/d' setup.py || die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}

pkg_postinst() {
	optfeature "integration with Django REST Framework" dev-python/djangorestframework
}
