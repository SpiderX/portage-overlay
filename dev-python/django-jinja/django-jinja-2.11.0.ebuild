# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Jinja2 templating language integrated in Django"
HOMEPAGE="https://github.com/niwinz/django-jinja"
SRC_URI="https://github.com/niwinz/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # fails

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]"
BDEPEND="test? ( $(python_gen_impl_dep sqlite)
		dev-python/pytz[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_test() {
	"${PYTHON}" testing/runtests.py || die "tests failed with ${EPYTHON}"
}
