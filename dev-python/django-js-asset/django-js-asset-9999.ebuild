# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )
EGIT_REPO_URI="https://github.com/matthiask/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="A script tag with additional attributes for django.forms.Media"
HOMEPAGE="https://github.com/matthiask/django-js-asset"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
BDEPEND="test? ( $(python_gen_impl_dep sqlite) )"

python_test() {
	./tests/manage.py test testapp --verbosity 2 || die "tests failed with ${EPYTHON}"
}
