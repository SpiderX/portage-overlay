# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
PYTHON_REQ_USE="sqlite(+)"

inherit distutils-r1 edo optfeature

DESCRIPTION="An asset packaging library for Django"
HOMEPAGE="https://github.com/jazzband/django-pipeline"
SRC_URI="https://github.com/jazzband/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? ( dev-python/jinja2[${PYTHON_USEDEP}]
		dev-python/jsmin[${PYTHON_USEDEP}]
		dev-python/ply[${PYTHON_USEDEP}]
		dev-util/css-html-js-minify[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

export DJANGO_SETTINGS_MODULE='tests.settings'
export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"

python_prepare_all() {
	# do not install docs and tests
	sed -i '/exclude/s|tests.tests|tests.*", "docs|' pyproject.toml \
		|| die "sed failed for pyproject.toml"

	distutils-r1_python_prepare_all
}

python_test() {
	local -x PYTHONPATH=.
	edo django-admin test -v2
}

pkg_postinst() {
	optfeature "integration with Closure Compiler compressor" dev-lang/closure-compiler-bin
	optfeature "integration with JSMin compressor" dev-python/jsmin
	optfeature "integration with css-html-js-minify" dev-util/css-html-js-minify
}
