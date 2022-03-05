# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/django-crispy-forms/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="DRY Django forms"
HOMEPAGE="https://github.com/django-crispy-forms/django-crispy-forms"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/pytest-django[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}
