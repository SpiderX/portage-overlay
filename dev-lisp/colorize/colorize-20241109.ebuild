# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="c41fcc5833ebcf184f48aaf31ab89a9a1c230464"

DESCRIPTION="A Syntax Highlighting library"
HOMEPAGE="https://github.com/kingcons/colorize"
SRC_URI="https://github.com/kingcons/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lisp/alexandria
	dev-lisp/html-encode
	dev-lisp/split-sequence"
BDEPEND="dev-lisp/asdf"
