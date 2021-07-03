# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Ordered YAML"
HOMEPAGE="https://github.com/wimglenn/oyaml"
SRC_URI="https://github.com/wimglenn/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # 659348

RDEPEND="dev-python/pyyaml[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
