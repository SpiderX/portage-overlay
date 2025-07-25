# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Use assumed role to open AWS console in default browser"
HOMEPAGE="https://github.com/trek10inc/awsume-console-plugin"
EGIT_REPO_URI="https://github.com/trek10inc/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-admin/awsume[${PYTHON_USEDEP}]"
