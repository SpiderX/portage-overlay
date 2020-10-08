# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )
EGIT_REPO_URI="https://github.com/nginxinc/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Fast and reliable NGINX configuration parser"
HOMEPAGE="https://github.com/nginxinc/crossplane"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT=0
KEYWORDS=""
IUSE=""

RDEPEND="dev-python/simplejson[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest
