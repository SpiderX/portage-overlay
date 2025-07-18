# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Use assumed role to open AWS console in default browser"
HOMEPAGE="https://github.com/trek10inc/awsume-console-plugin"
SRC_URI="https://github.com/trek10inc/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-admin/awsume[${PYTHON_USEDEP}]"
