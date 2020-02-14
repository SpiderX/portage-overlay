# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )
EGIT_REPO_URI="https://github.com/pythongssapi/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="A library for setting up self-contained Kerberos 5 environments"
HOMEPAGE="https://github.com/pythongssapi/k5test"
SRC_URI=""

LICENSE="ISC MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/six[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	app-crypt/mit-krb5"
