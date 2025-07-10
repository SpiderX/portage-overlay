# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="aabfe28c6c1a4949f9d7b3cb30319367c9fd1c0d"

DESCRIPTION="A few utility functions from the LispWorks library"
HOMEPAGE="https://github.com/pcostanza/lw-compat"
SRC_URI="https://github.com/pcostanza/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="dev-lisp/asdf"
