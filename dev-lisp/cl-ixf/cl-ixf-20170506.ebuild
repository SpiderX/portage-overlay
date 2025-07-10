# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="ed26f87e4127e4a9e3aac4ff1e60d1f39cca5183"

DESCRIPTION="Tools to handle IBM PC version of IXF file format"
HOMEPAGE="https://github.com/dimitri/cl-ixf"
SRC_URI="https://github.com/dimitri/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lisp/alexandria
	dev-lisp/babel
	dev-lisp/cl-ppcre
	dev-lisp/ieee-floats
	dev-lisp/local-time
	dev-lisp/md5
	dev-lisp/split-sequence"
BDEPEND="dev-lisp/asdf"
