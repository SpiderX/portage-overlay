# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 optfeature

DESCRIPTION="Tree queries with explicit opt-in, without configurability"
HOMEPAGE="https://github.com/feincms/django-tree-queries"
SRC_URI="https://github.com/feincms/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/django-js-asset[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-django )
distutils_enable_tests pytest

export DJANGO_SETTINGS_MODULE=testapp.settings

src_prepare() {
	default

	# remove coverage
	sed -i '/addopts/d' pyproject.toml || die "sed failed"
}

python_test() {
	local -x PYTHONPATH=tests
	epytest
}

pkg_postinst() {
	optfeature "integration with django-js-asset" dev-python/django-js-asset
}
