# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="An environment variables to configure Django"
HOMEPAGE="https://github.com/joke2k/django-environ"
EGIT_REPO_URI="https://github.com/joke2k/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# needs postgres
	tests/test_db.py::test_db_parsing
)
