# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Plugin for Poetry to enable dynamic versioning based on VCS tags"
HOMEPAGE="https://github.com/mtkennerly/poetry-dynamic-versioning"
EGIT_REPO_URI="https://github.com/mtkennerly/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/dunamai[${PYTHON_USEDEP}]
	dev-python/tomlkit[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}/${PN}"-1.8.2-tests.patch )

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# ignore intergration tests
	tests/test_integration.py
)
