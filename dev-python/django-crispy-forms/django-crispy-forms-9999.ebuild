# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..7}} )
EGIT_REPO_URI="https://github.com/django-crispy-forms/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="DRY Django forms"
HOMEPAGE="https://github.com/django-crispy-forms/django-crispy-forms"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( $(python_gen_impl_dep sqlite)
		dev-python/pytest-django[${PYTHON_USEDEP}] )"

# Add manage.py to run tests
PATCHES=( "${FILESDIR}/${PN}"-1.7.2-manage.py.patch )

python_prepare_all() {
	# fix config to remove warning
	sed -i '/pytest/s/\[/\[tool:/' setup.cfg || die "sed failed for setup.cfg"
	distutils-r1_python_prepare_all
}

python_test() {
	DJANGO_SETTINGS_MODULE=crispy_forms.tests.test_settings py.test -v \
		|| die "tests failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}
