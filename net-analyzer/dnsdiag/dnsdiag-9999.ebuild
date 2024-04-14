# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..12} )
EGIT_REPO_URI="https://github.com/farrokhi/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="DNS Measurement, Troubleshooting and Security Auditing Toolset"
HOMEPAGE="https://github.com/farrokhi/dnsdiag"

LICENSE="BSD-2"
SLOT="0"

RDEPEND="dev-python/dnspython[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/requests-toolbelt[${PYTHON_USEDEP}]
	net-analyzer/cymruwhois[${PYTHON_USEDEP}]"
