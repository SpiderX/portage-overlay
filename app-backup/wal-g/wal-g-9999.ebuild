# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/wal-g/${PN}.git"
EGIT_SUBMODULES=()

inherit git-r3 go-module

DESCRIPTION="Archival restoration tool for databases"
HOMEPAGE="https://github.com/wal-g/wal-g"
SRC_URI=""

LICENSE="Apache-2.0 GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE="fdb lzo mongo mysql +postgres redis sodium"
REQUIRED_USE="|| ( fdb mongo mysql postgres redis )"
RESTRICT="test" # fails

DEPEND="app-arch/brotli:=
	lzo? ( dev-libs/lzo:2 )
	sodium? ( dev-libs/libsodium:= )"
RDEPEND="${DEPEND}"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
	for db in fdb gp mongo mysql postgres redis sqlserver ; do
		if use "$db" ; then
			if [ "$db" == "postgres" ] ; then db="pg" ; fi
			go build -o wal-g-"$db" \
				-tags "brotli $(usex lzo lzo '' '' '') $(usex sodium libsodium '' '' '')" \
				-ldflags "-X github.com/wal-g/wal-g/cmd/$db.walgVersion=${PV}
					-X \"github.com/wal-g/wal-g/cmd/$db.buildDate=${DATE}\"
					-X github.com/wal-g/wal-g/cmd/mongo.gitRevision=${COMMIT}" \
				./main/"$db"/... || die "build failed for $db"
		fi
	done
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	use fdb && dobin wal-g-fdb
	use gp && dobin wal-g-gp
	use mongo && dobin wal-g-mongo
	use mysql && dobin wal-g-mysql
	use postgres && dobin wal-g-pg
	use redis && dobin wal-g-redis
	use sqlserver && dobin wal-g-sqlserver
}
