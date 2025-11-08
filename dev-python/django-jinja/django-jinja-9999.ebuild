# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )
PYTHON_REQ_USE="sqlite(+)"

inherit distutils-r1 edo git-r3

DESCRIPTION="Jinja2 templating language integrated in Django"
HOMEPAGE="https://github.com/niwinz/django-jinja"
EGIT_REPO_URI="https://github.com/niwinz/${PN}.git"

LICENSE="BSD"
SLOT="0"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/pytz[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_test() {
	edo pushd testing
	"${PYTHON}" runtests.py || die "tests failed with ${EPYTHON}"
	edo popd
}
