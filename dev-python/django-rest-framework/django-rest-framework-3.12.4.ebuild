# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 optfeature

DESCRIPTION="Django REST framework"
HOMEPAGE="https://django-rest-framework.org"
SRC_URI="https://github.com/encode/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
BDEPEND="test? ( $(python_gen_impl_dep sqlite)
		dev-python/coreapi[${PYTHON_USEDEP}]
		dev-python/coreschema[${PYTHON_USEDEP}]
		dev-python/django-guardian[${PYTHON_USEDEP}]
		dev-python/markdown[${PYTHON_USEDEP}]
		dev-python/psycopg:2[${PYTHON_USEDEP}]
		dev-python/pytest-django[${PYTHON_USEDEP}] )"

PATCHES="${FILESDIR}/${P}-test-markdown.patch"

distutils_enable_tests pytest

python_prepare_all() {
	# Backport test fix
	sed -i '/class MockTimezone/s/:/(pytz.BaseTzInfo):/' tests/test_fields.py \
		die "sed failed for test_fields.py"
	distutils-r1_python_prepare_all
}

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
