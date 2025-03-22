# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..13} python3_13t )

inherit distutils-r1 pypi

DESCRIPTION="Python 3 DNS library"
HOMEPAGE="https://launchpad.net/py3dns"

LICENSE="PYTHON"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # non-existed domains

distutils_enable_tests unittest
