# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/wal-g/wal-g.git"

inherit git-r3 go-module

DESCRIPTION="Archival restoration tool for databases"
HOMEPAGE="https://github.com/wal-g/wal-g"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="lzo mongo mysql postgres redis sodium"
REQUIRED_USE="|| ( mongo mysql postgres redis )"
RESTRICT="test" # needs docker

DEPEND="app-arch/brotli:=
	lzo? ( dev-libs/lzo:2 )
	sodium? ( dev-libs/libsodium:= )"
RDEPEND="${DEPEND}"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	for db in mongo mysql postgres redis ; do
		if use "$db" ; then
			if [ "$db" == "postgres" ] ; then db="pg" ; fi
			go build -o wal-g-"$db" \
				-tags "brotli $(usex lzo lzo '' '' '') $(usex sodium libsodium '' '' '')" \
				-ldflags "-X github.com/wal-g/wal-g/cmd/$db.WalgVersion=${PV}" \
				./main/"$db"/... || die "build failed for $db"
		fi
	done
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	use mongo && dobin wal-g-mongo
	use mysql && dobin wal-g-mysql
	use postgres && dobin wal-g-pg
	use redis && dobin wal-g-redis
}
