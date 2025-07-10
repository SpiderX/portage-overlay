# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="64c8c8a6be723011b184a7800ac99df6dbfdd756"

DESCRIPTION="Common Lisp library for interacting with MS SQL databases"
HOMEPAGE="https://github.com/archimag/cl-mssql"
SRC_URI="https://github.com/archimag/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-db/freetds[mssql]
	dev-lisp/cffi
	dev-lisp/iterate
	dev-lisp/garbage-pools
	dev-lisp/parse-number"
