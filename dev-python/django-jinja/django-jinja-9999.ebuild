# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/niwinz/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Jinja2 templating language integrated in Django"
HOMEPAGE="https://github.com/niwinz/django-jinja"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
RESTRICT="test" # https://github.com/niwinz/django-jinja/issues/181

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( $(python_gen_impl_dep sqlite)
		dev-python/django-pipeline[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_test() {
	"${PYTHON}" testing/runtests.py || die "tests failed with ${EPYTHON}"
}
