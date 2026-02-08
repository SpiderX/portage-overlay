# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="An implementation of a LDAPObject to fake a ldap server"
HOMEPAGE="https://github.com/zulip/fakeldap"
EGIT_REPO_URI="https://github.com/zulip/${PN}.git"

LICENSE="BSD"
SLOT="0"

DEPEND="dev-python/python-ldap[${PYTHON_USEDEP}]"
