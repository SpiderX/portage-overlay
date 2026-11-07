# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit go-module

COMMIT="3e49318"

DESCRIPTION="Archival restoration tool for databases"
HOMEPAGE="https://github.com/wal-g/wal-g"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="Apache-2.0 GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="brotli etcd fdb gp lzo mongo mysql +postgres redis sqlserver sodium test"
REQUIRED_USE="|| ( etcd fdb mongo mysql postgres redis ) test? ( sodium )"
RESTRICT="!test? ( test )"

RDEPEND="brotli? ( app-arch/brotli:= )
	lzo? ( dev-libs/lzo:2 )
	sodium? ( dev-libs/libsodium:= )"
BDEPEND=">=dev-lang/go-1.27"

src_compile() {
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
	# upstream uses Go 1.27 JSON APIs but declares Go 1.25.11.
	# Exclude stdversion from the default go vet analyzers.
	ego test -count=1 \
		-vet=atomic,bools,buildtag,directive,errorsas,ifaceassert,nilfunc,printf,slog,stringintconv,tests \
		./internal/... ./pkg/... ./utility/...
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
