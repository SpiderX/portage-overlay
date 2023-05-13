# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,10} )
EGIT_REPO_URI="https://github.com/coala/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="A simple GIT URL parser"
HOMEPAGE="https://github.com/coala/git-url-parse"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

BDEPEND="dev-python/pbr[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_prepare_all() {
	# Disable pytest plugins
	sed -i '/addopts/s/^/#/' pytest.ini \
		|| die "sed for pytest.ini failed"

	distutils-r1_python_prepare_all
}
