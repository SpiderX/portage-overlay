# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Detects what shell the current Python executable is running in"
HOMEPAGE="https://github.com/sarugaku/shellingham"
SRC_URI="https://github.com/sarugaku/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="test? ( dev-python/pytest-mock[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
