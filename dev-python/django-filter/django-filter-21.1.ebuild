# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 optfeature

DESCRIPTION="Django application for filtering querysets"
HOMEPAGE="https://github.com/carltongibson/django-filter"
SRC_URI="https://github.com/carltongibson/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
BDEPEND="test? ( $(python_gen_impl_dep sqlite)
		dev-python/coreapi[${PYTHON_USEDEP}]
		dev-python/django-crispy-forms[${PYTHON_USEDEP}]
		dev-python/django-rest-framework[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest

python_test() {
	./runtests.py --verbosity 2 || die "tests failed with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "enhancing the presentation of the filter forms in HTML views" dev-python/django-crispy-forms
	optfeature "custom FilterSet and filter backend for Django REST Framework" dev-python/django-rest-framework
	optfeature "integration with Core API" dev-python/coreapi
	optfeature "integration with Django REST Framework schema generation" dev-python/coreschema
}
