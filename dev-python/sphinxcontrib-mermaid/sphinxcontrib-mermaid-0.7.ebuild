# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Mermaid diagrams in sphinx powered docs"
HOMEPAGE="https://github.com/mgaitan/sphinxcontrib-mermaid"
SRC_URI="https://github.com/mgaitan/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/namespace-sphinxcontrib[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/recommonmark[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -name '*.pth' -delete || die "removing of *.pth failed"
}
