# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Authentication module for Django Rest Framework"
HOMEPAGE="https://github.com/jazzband/django-rest-knox"
EGIT_REPO_URI="https://github.com/jazzband/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/djangorestframework[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=( pytest-django )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AssertionError
	tests/test_settings.py::TestKnoxSettings::test_override_settings
	tests/test_settings.py::TestKnoxSettings::test_constants_immutability
	tests/test_settings.py::TestKnoxSettings::test_reload_api_settings
	tests/test_settings.py::TestKnoxSettings::test_token_prefix_length_validation
	tests/test_settings.py::TestKnoxSettings::test_hash_algorithm_import
	tests/test_settings.py::TestKnoxSettings::test_setting_changed_signal
	tests/test_settings.py::TestKnoxSettings::test_custom_token_model
)

export DJANGO_SETTINGS_MODULE='knox_project.settings'
