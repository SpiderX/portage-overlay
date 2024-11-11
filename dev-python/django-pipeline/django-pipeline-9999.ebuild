# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/jazzband/${PN}.git"

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="An asset packaging library for Django"
HOMEPAGE="https://github.com/jazzband/django-pipeline"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( $(python_gen_impl_dep sqlite)
		dev-python/jinja2[${PYTHON_USEDEP}]
		dev-python/jsmin[${PYTHON_USEDEP}]
		dev-python/ply[${PYTHON_USEDEP}]
		dev-python/slimit[${PYTHON_USEDEP}]
		dev-util/css-html-js-minify[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_test() {
	PYTHONPATH=. django-admin.py test --settings=tests.settings tests -v2 \
		|| die "tests failed with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "integration with Closure Compiler compressor" dev-lang/closure-compiler-bin
	optfeature "integration with JSMin compressor" dev-python/jsmin
	optfeature "integration with SlimIt compressor" dev-python/slimit
	optfeature "integration with YUI compressor" dev-util/yuicompressor
	optfeature "integration with css-html-js-minify" dev-util/css-html-js-minify
}
