# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EDARCS_REPOSITORY="https://hub.darcs.net/hu.dwim/hu.dwim.rdbms"

inherit common-lisp-3 darcs

MY_PN="${PN//-/.}"

DESCRIPTION="Relational database independent RDBMS and SQL abstractions"
HOMEPAGE="https://hub.darcs.net/hu.dwim/hu.dwim.rdbms"

LICENSE="MIT-0"
SLOT="0"
IUSE="doc oracle postgres sqlite test"
REQUIRED_USE="doc? ( test ) test? ( oracle postgres sqlite )"
RESTRICT="test" # build error

PDEPEND="dev-lisp/hu-dwim-util"
RDEPEND="dev-lisp/babel
	dev-lisp/cffi
	dev-lisp/hu-dwim-asdf
	dev-lisp/hu-dwim-defclass-star
	dev-lisp/hu-dwim-logger
	dev-lisp/hu-dwim-syntax-sugar
	dev-lisp/hu-dwim-walker
	dev-lisp/ironclad
	dev-lisp/local-time
	doc? ( dev-lisp/hu-dwim-presentation )
	oracle? ( dev-db/oracle-instantclient )
	postgres? ( dev-db/postgresql
		dev-lisp/postmodern )
	sqlite? ( dev-db/sqlite:3 )"
BDEPEND="test? ( dev-lisp/asdf
		dev-lisp/hu-dwim-stefil )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :hu.dwim.rdbms.all.test)" \
		|| die "test failed"
}
