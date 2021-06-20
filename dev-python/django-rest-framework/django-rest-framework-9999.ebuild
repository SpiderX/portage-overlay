# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/encode/${PN}.git"

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="Django REST framework"
HOMEPAGE="https://django-rest-framework.org"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
BDEPEND="test? ( $(python_gen_impl_dep sqlite)
		dev-python/coreapi[${PYTHON_USEDEP}]
		dev-python/coreschema[${PYTHON_USEDEP}]
		dev-python/django-guardian[${PYTHON_USEDEP}]
		dev-python/markdown[${PYTHON_USEDEP}]
		dev-python/psycopg:2[${PYTHON_USEDEP}]
		>=dev-python/pytest-django-3.5.1[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_test() {
	./runtests.py -v --nolint || die "tests failed with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "integration with Core API" dev-python/coreapi
	optfeature "integration with Core API schema generation" dev-python/coreschema
	optfeature "integration with filtering backend" dev-python/django-filter
	optfeature "integration with permission backend" dev-python/django-guardian
	optfeature "support for markdown syntax" dev-python/markdown
	optfeature "support for PostgreSQL" dev-python/psycopg:2
	optfeature "highlighting" dev-python/pygments
	optfeature "render schema in yaml" dev-python/pyyaml
}
