# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://git.launchpad.net/py3dns"

inherit distutils-r1 git-r3

DESCRIPTION="Python 3 DNS library"
HOMEPAGE="https://launchpad.net/py3dns"
SRC_URI=""

LICENSE="PYTHON"
SLOT="0"
KEYWORDS=""
PROPERTIES="live test_network"
RESTRICT="test"

distutils_enable_tests unittest
