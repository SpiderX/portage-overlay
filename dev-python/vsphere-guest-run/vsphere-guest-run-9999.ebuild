# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
EGIT_REPO_URI="https://github.com/vmware/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Python library for guest operations"
HOMEPAGE="https://github.com/vmware/vsphere-guest-run"

LICENSE="BSD-2"
SLOT="0"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/pyvmomi[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]"
BDEPEND="dev-python/pbr[${PYTHON_USEDEP}]"
