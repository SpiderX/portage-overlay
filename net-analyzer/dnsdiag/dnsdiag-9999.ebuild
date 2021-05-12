# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
EGIT_REPO_URI="https://github.com/farrokhi/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="DNS Measurement, Troubleshooting and Security Auditing Toolset"
HOMEPAGE="https://github.com/farrokhi/dnsdiag"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/dnspython[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/requests-toolbelt[${PYTHON_USEDEP}]
	net-analyzer/python-cymruwhois[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
