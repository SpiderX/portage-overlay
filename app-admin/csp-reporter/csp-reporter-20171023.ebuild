# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )
EGIT_REPO_URI="https://github.com/yandex/${PN}.git"

inherit distutils-r1

COMMIT="b4aeddc5e6a0c7595502da47ea6383864faf90dc"

DESCRIPTION="Content Security Policy logs parser"
HOMEPAGE="https://github.com/yandex/csp-reporter"
SRC_URI="https://github.com/yandex/${PN}/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/jinja[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}-${COMMIT}"

DOCS=( README.md config.ini-sample )
