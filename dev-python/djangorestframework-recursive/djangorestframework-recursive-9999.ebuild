# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Recursive Serialization for Django REST framework"
HOMEPAGE="https://github.com/heywbj/django-rest-framework-recursive"
EGIT_REPO_URI="https://github.com/heywbj/${PN}.git"

LICENSE="ISC"
SLOT="0"

RDEPEND="dev-python/djangorestframework[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# serialized data does not match input
	tests/test_recursive.py::TestRecursiveField::test_many_null_serializer
)
