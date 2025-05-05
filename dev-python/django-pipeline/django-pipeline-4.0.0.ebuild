# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature

DESCRIPTION="An asset packaging library for Django"
HOMEPAGE="https://github.com/jazzband/django-pipeline"
SRC_URI="https://github.com/jazzband/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? ( $(python_gen_impl_dep sqlite)
		dev-python/jinja2[${PYTHON_USEDEP}]
		dev-python/jsmin[${PYTHON_USEDEP}]
		dev-python/ply[${PYTHON_USEDEP}]
		dev-util/css-html-js-minify[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

export DJANGO_SETTINGS_MODULE=tests.settings
export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"

EPYTEST_DESELECT=(
	# ModuleNotFoundError: No module named 'css_html_js_minify'
	tests/tests/test_compressor.py::CompressorImplementationTest::test_csshtmljsminify
	# OSError: File does not exist: pipeline/css/first.css
	tests/tests/test_forms.py::PipelineFormMediaTests::test_css_packages_with_pipeline_disabled
	# OSError: File does not exist: pipeline/js/first.js
	tests/tests/test_forms.py::PipelineFormMediaTests::test_js_packages_with_pipeline_disabled
	# TypeError: PipelineFinder.find() got an unexpected keyword argument 'find_all'
	tests/tests/test_storage.py::StorageTest::test_nonexistent_double_extension_file_cached_finder
	tests/tests/test_storage.py::StorageTest::test_nonexistent_double_extension_file_pipeline_finder
	tests/tests/test_storage.py::StorageTest::test_nonexistent_file_cached_finder
	tests/tests/test_storage.py::StorageTest::test_nonexistent_file_pipeline_finder
)

python_prepare_all() {
	# do not install docs and tests
	sed -i '/exclude/s|tests.tests|tests.*", "docs|' pyproject.toml \
		|| die "sed failed for pyproject.toml"

	distutils-r1_python_prepare_all
}

pkg_postinst() {
	optfeature "integration with Closure Compiler compressor" dev-lang/closure-compiler-bin
	optfeature "integration with JSMin compressor" dev-python/jsmin
	optfeature "integration with SlimIt compressor" dev-python/slimit
	optfeature "integration with YUI compressor" dev-util/yuicompressor
	optfeature "integration with css-html-js-minify" dev-util/css-html-js-minify
}
