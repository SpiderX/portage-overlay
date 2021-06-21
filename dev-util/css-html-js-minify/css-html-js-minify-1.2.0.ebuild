# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="StandAlone Async cross-platform Minifier for the Web"
HOMEPAGE="https://github.com/juancarlospaco/css-html-js-minify"
SRC_URI="https://github.com/juancarlospaco/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
