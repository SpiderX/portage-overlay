# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/dimitri/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="A data loading tool for PostgreSQL, using the COPY command"
HOMEPAGE="https://github.com/dimitri/pgloader"

LICENSE="POSTGRESQL"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test ) strip"

RDEPEND="app-arch/zstd:0=
	dev-lisp/alexandria
	dev-lisp/asdf-finalizers
	dev-lisp/cffi
	dev-lisp/cl-abnf
	dev-lisp/cl-base64
	dev-lisp/cl-csv
	dev-lisp/cl-db3
	dev-lisp/cl-fad
	dev-lisp/cl-ixf
	dev-lisp/cl-log
	dev-lisp/cl-markdown
	dev-lisp/cl-mssql
	dev-lisp/cl-mustache
	dev-lisp/closer-mop
	dev-lisp/cl-plus-ssl
	dev-lisp/cl-ppcre
	dev-lisp/cl-sqlite
	dev-lisp/cl-utilities
	dev-lisp/command-line-arguments
	dev-lisp/drakma
	dev-lisp/esrap
	dev-lisp/flexi-streams
	dev-lisp/local-time
	dev-lisp/lparallel
	dev-lisp/metabang-bind
	dev-lisp/postmodern
	dev-lisp/py-configparser
	dev-lisp/qmynd
	dev-lisp/quri
	dev-lisp/split-sequence
	dev-lisp/trivial-backtrace
	dev-lisp/uiop
	dev-lisp/usocket
	dev-lisp/uuid
	dev-lisp/yason
	dev-lisp/zs3"
BDEPEND="dev-lisp/asdf
	dev-lisp/buildapp
	test? ( dev-db/ip4r )"

QA_FLAGS_IGNORED="/usr/bin/pgloader"

src_prepare() {
	default

	# fix typo
	sed -i 's/x text/c text/' test/csv-missing-col.load \
		|| die "sed failed for csv-missing-col.load"
}

src_compile() {
	buildapp --require sb-posix \
		--require sb-bsd-sockets \
		--require sb-rotate-byte \
		--asdf-path . \
		--asdf-tree /usr/share/common-lisp/systems \
		--load /usr/share/common-lisp/source/asdf/build/asdf.lisp \
		--load-system asdf-finalizers \
		--load-system cffi \
		--load-system cl+ssl \
		--load-system mssql \
		--load-system pgloader \
		--load src/hooks.lisp \
		--entry pgloader:main \
		--dynamic-space-size "$(usex amd64 16384 1024)" \
		--compress-core \
		--output build/bin/pgloader || die "buildapp failed"
}

src_test() {
	local db="${T}/pgsql"
	initdb -U portage -A trust -D "${db}" || die "initdb failed"
	pg_ctl -w -D "${db}" start -o "-h '127.0.0.1' -p 5432 -k '${T}'" \
		|| die "pg_ctl for start failed"
	PGSUPERUSER="portage" PGUSER="portage" PGHOST="${T}" \
		emake -j1 -C test prepare regress
	pg_ctl -w -D "${db}" stop || die "pg_ctl for stop failed"
}

src_install() {
	dobin build/bin/pgloader
}
