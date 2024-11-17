# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/hraban/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Common Lisp library for interacting with MS SQL databases"
HOMEPAGE="https://github.com/archimag/cl-mssql"

LICENSE="LLGPL-2.1"
SLOT="0"

RDEPEND="dev-db/freetds[mssql]
	dev-lisp/cffi
	dev-lisp/iterate
	dev-lisp/garbage-pools
	dev-lisp/parse-number"
