# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/migonzalvar/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="URL based email backend configuration in Django"
HOMEPAGE="https://github.com/migonzalvar/dj-email-url"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"

distutils_enable_tests unittest
