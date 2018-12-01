# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )

inherit distutils-r1 eutils

DESCRIPTION="Django application for filtering querysets"
HOMEPAGE="https://github.com/carltongibson/django-filter"
SRC_URI="https://github.com/carltongibson/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	virtual/python-futures[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/django-crispy-forms[${PYTHON_USEDEP}]
		dev-python/django-rest-framework[${PYTHON_USEDEP}]
		dev-python/python-coreapi[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
		virtual/python-unittest-mock[${PYTHON_USEDEP}] )"

python_test() {
	./runtests.py || die "tests failed with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "enhancing the presentation of the filter forms in HTML views" dev-python/django-crispy-forms
	optfeature "custom FilterSet and filter backend for Django REST Framework" dev-python/django-rest-framework
	optfeature "integration with Core API" dev-python/python-coreapi
	optfeature "integration with Django REST Framework schema generation" dev-python/python-coreschema
}
