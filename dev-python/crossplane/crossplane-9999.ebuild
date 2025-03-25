# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Fast and reliable NGINX configuration parser"
HOMEPAGE="https://github.com/nginxinc/crossplane"
EGIT_REPO_URI="https://github.com/nginxinc/${PN}.git"

LICENSE="Apache-2.0"
SLOT=0

RDEPEND="dev-python/simplejson[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
