# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/wimglenn/${PN}.git"
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 git-r3

DESCRIPTION="Ordered YAML"
HOMEPAGE="https://github.com/wimglenn/oyaml"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
RESTRICT="test" # 659348

RDEPEND="dev-python/pyyaml[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
