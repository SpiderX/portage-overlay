# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="38e5ad35f025769fb7f8dcdc6e56df3e8efd8e6d"

DESCRIPTION="A Common Lisp lib to read dbf files version 3"
HOMEPAGE="https://github.com/dimitri/cl-db3"
SRC_URI="https://github.com/dimitri/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="dev-lisp/asdf"
