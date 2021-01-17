# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} )
EGIT_REPO_URI="https://github.com/Yinzo/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Binding variables and refreshing multi-line output in terminal"
HOMEPAGE="https://github.com/Yinzo/reprint"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
