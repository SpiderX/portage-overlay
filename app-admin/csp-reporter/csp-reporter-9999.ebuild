# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/yandex/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Content Security Policy logs parser"
HOMEPAGE="https://github.com/yandex/csp-reporter"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/jinja[${PYTHON_USEDEP}]"

DOCS=( README.md config.ini-sample )
