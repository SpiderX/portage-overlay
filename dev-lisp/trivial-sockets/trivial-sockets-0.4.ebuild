# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

DESCRIPTION="A trivial networking library for Common Lisp"
HOMEPAGE="https://github.com/usocket/trivial-sockets"
SRC_URI="https://github.com/usocket/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="dev-lisp/asdf"
