# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="A simple GIT URL parser"
HOMEPAGE="https://github.com/coala/git-url-parse"
EGIT_REPO_URI="https://github.com/coala/${PN}.git"

LICENSE="MIT"
SLOT="0"

BDEPEND="dev-python/pbr[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_prepare_all() {
	# disable pytest plugins
	sed -i '/addopts/s/^/#/' pytest.ini \
		|| die "sed for pytest.ini failed"

	distutils-r1_python_prepare_all
}
