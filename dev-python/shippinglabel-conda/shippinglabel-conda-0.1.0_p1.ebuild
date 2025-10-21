# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

MY_PV="${PV/_p/.post}"

DESCRIPTION="Shippinglabel extension with utilities conda packages"
HOMEPAGE="https://github.com/domdfcoding/shippinglabel-conda"
SRC_URI="https://github.com/domdfcoding/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/apeye[${PYTHON_USEDEP}]
	dev-python/domdf-python-tools[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/platformdirs[${PYTHON_USEDEP}]
	dev-python/shippinglabel[${PYTHON_USEDEP}]"
BDEPEND="dev-python/whey[${PYTHON_USEDEP}]
	test? ( dev-python/coincidence[${PYTHON_USEDEP}]
		dev-python/consolekit[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-{datadir,regressions,rerunfailures,timeout} )

distutils_enable_tests pytest

src_prepare() {
	default

	# do not check for prettyprinter in conda channel as removed
	sed -i '/assert "prettyprinter" in listing/d' tests/test_conda.py \
		|| die "sed failed for test_conda.py"
}
