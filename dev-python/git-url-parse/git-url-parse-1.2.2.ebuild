# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,10} )

inherit distutils-r1

DESCRIPTION="A simple GIT URL parser"
HOMEPAGE="https://github.com/coala/git-url-parse"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="dev-python/pbr[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_prepare_all() {
	# Disable pytest plugins
	sed -i '/addopts/s/^/#/' pytest.ini \
		|| die "sed for pytest.ini failed"

	distutils-r1_python_prepare_all
}
