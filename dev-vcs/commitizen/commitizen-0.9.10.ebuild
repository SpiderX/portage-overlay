# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )

inherit distutils-r1

DESCRIPTION="Python commitizen client tool"
HOMEPAGE="https://github.com/Woile/commitizen"
SRC_URI="https://github.com/Woile/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/delegator-py[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
	<dev-python/prompt_toolkit-2[${PYTHON_USEDEP}]
	dev-python/whaaaaat[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/configparser[${PYTHON_USEDEP}]' -2 )
	$(python_gen_cond_dep 'dev-python/pathlib2[${PYTHON_USEDEP}]' -2 )"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
