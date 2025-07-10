# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 common-lisp-3 toolchain-funcs

MY_PN="cl-sql"

DESCRIPTION="A multi-platform SQL interface for Common Lisp"
HOMEPAGE="https://github.com/sharplispers/clsql"
EGIT_REPO_URI="https://github.com/sharplispers/${PN}.git"

LICENSE="MIT"
SLOT="0"
IUSE="mysql odbc oracle postgres sqlite test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/cffi
	dev-lisp/md5
	mysql? ( virtual/mysql )
	odbc? ( dev-db/unixODBC )
	oracle? ( dev-db/oracle-instantclient )
	postgres? ( dev-db/postgresql
		dev-lisp/postmodern )
	sqlite? ( dev-db/sqlite:3 )"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/rt )"

src_prepare() {
	default

	# respect libdir
	sed -i  -e "s,/usr/lib,/usr/$(get_libdir),g" \
		-e 's,"usr" "lib","usr" "'$(get_libdir)'",g' \
		clsql-mysql.asd || die "sed failed for clsql-mysql.asd"

	# use right compiler
	sed -i 's/gcc/$(CC)/' {uffi,db-mysql}/Makefile \
		|| die "sed failed for Makefile"

	# respect CFLAGS and LDFLAGS
	sed -i  -e '/^CFLAGS:=/s/$/ $(CFLAGS)/' \
		-e '/^LDFLAGS:=/s/$/ $(LDFLAGS)/' \
		db-mysql/Makefile || die "sed failed for Makefile"
}

src_configure() {
	if ! use mysql ; then
		sed -i '/SUBDIRS/s|db-mysql ||' Makefile \
			|| die "sed failed for mysql"
	fi
}

src_compile() {
	OS_DPKG_BUILDFLAGS=0 emake CC="$(tc-getCC)"
}

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :clsql)" \
		|| die "test failed"
}

src_install() {
	einstalldocs

	common-lisp-install-sources sql tests uffi db-aodbc db-db2
	common-lisp-install-asdf clsql clsql-{aodbc,cffi,db2,uffi,tests}

	exeinto /usr/"$(get_libdir)"/clsql
	doexe uffi/clsql_uffi64.so
	use mysql && doexe db-mysql/clsql_mysql64.so

	if use mysql ; then
		common-lisp-install-sources db-mysql
		common-lisp-install-asdf clsql-mysql
	fi

	if use odbc ; then
		common-lisp-install-sources db-odbc
		common-lisp-install-asdf clsql-odbc
	fi

	if use oracle ; then
		common-lisp-install-sources db-oracle
		common-lisp-install-asdf clsql-oracle
	fi

	if use postgres ; then
		common-lisp-install-sources db-postgresql{,-socket,-socket3}
		common-lisp-install-asdf clsql-postgresql{,-socket,-socket3}
	fi

	if use sqlite ; then
		common-lisp-install-sources db-sqlite{,3}
		common-lisp-install-asdf clsql-sqlite{,3}
	fi

	insinto /etc
	newins - clsql-init.lisp <<-EOF
	(clsql:push-library-path #p"/usr/$(get_libdir)/")
	(clsql:push-library-path #p"/usr/$(get_libdir)/clsql/")
	EOF
}
