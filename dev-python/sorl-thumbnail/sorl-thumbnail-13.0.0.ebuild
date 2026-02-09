# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Thumbnails for Django"
HOMEPAGE="https://github.com/jazzband/sorl-thumbnail"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? ( dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/redis[${PYTHON_USEDEP}]
		dev-python/wand[${PYTHON_USEDEP}]
		sys-process/lsof )"

export DJANGO_SETTINGS_MODULE=tests.settings.default

EPYTEST_PLUGINS=( pytest-django )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AssertionError
	tests/thumbnail_tests/test_engines.py::SimpleTestCase::test_quality
	tests/thumbnail_tests/test_templatetags.py::TemplateTestCaseA::test_nonprogressive
	tests/thumbnail_tests/test_templatetags.py::TemplateTestCaseA::test_progressive
	# RuntimeError
	tests/thumbnail_tests/test_backends.py::TestInputCase::test_nonascii
	tests/thumbnail_tests/test_engines.py::DummyTestCase::test_dummy_tags
)

pkg_postinst() {
	optfeature "integration with pillow" dev-python/pillow
	optfeature "integration with redis"  dev-python/redis
	optfeature "integration with wand" dev-python/wand
}
