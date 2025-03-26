# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="A SQL linter and auto-formatter"
HOMEPAGE="https://github.com/sqlfluff/sqlfluff"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/pathspec[${PYTHON_USEDEP}]
	dev-python/platformdirs[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]
	dev-python/tblib[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-util/diff-cover[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}/${PN}"-3.1.0-test-fixture.patch )

distutils_enable_tests pytest
