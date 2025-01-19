# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/wal-g/${PN}.git"
EGIT_SUBMODULES=()

inherit git-r3 go-module

DESCRIPTION="Archival restoration tool for databases"
HOMEPAGE="https://github.com/wal-g/wal-g"

LICENSE="Apache-2.0 GPL-3+"
SLOT="0"
IUSE="brotli etcd fdb gp lzo mongo mysql +postgres redis sqlserver sodium"
REQUIRED_USE="|| ( etcd fdb mongo mysql postgres redis )"
RESTRICT="test" # fails

RDEPEND="brotli? ( app-arch/brotli:= )
	lzo? ( dev-libs/lzo:2 )
	sodium? ( dev-libs/libsodium:= )"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	COMMIT="$(git rev-parse --short HEAD)"
	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
	TAGS="$(usex brotli brotli '' '' '') $(usex lzo lzo '' '' '') $(usex sodium libsodium '' '' '')"
	for db in etcd fdb gp mongo mysql postgres redis sqlserver ; do
		if use "$db" ; then
			if [ "$db" == "postgres" ] ; then db="pg" ; fi
			ego build -o wal-g-"$db" -tags "${TAGS}" \
				-ldflags "-X github.com/wal-g/wal-g/cmd/$db.walgVersion=${PV}
					-X \"github.com/wal-g/wal-g/cmd/$db.buildDate=${DATE}\"
					-X github.com/wal-g/wal-g/cmd/$db.gitRevision=${COMMIT}" \
				./main/"$db"/...
		fi
	done
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	use etcd && dobin wal-g-etcd
	use fdb && dobin wal-g-fdb
	use gp && dobin wal-g-gp
	use mongo && dobin wal-g-mongo
	use mysql && dobin wal-g-mysql
	use postgres && dobin wal-g-pg
	use redis && dobin wal-g-redis
	use sqlserver && dobin wal-g-sqlserver
}
