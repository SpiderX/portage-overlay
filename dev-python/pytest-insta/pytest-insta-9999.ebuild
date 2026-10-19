# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 git-r3

DESCRIPTION="A practical snapshot testing plugin for pytest"
HOMEPAGE="https://github.com/vberlier/pytest-insta"
EGIT_REPO_URI="https://github.com/vberlier/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/wrapt[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_test() {
	epytest -p pytest_insta.plugin
}
