# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

POSTGRES_COMPAT=( {14..18} )
POSTGRES_USEDEP="server"

inherit edo go-module postgres readme.gentoo-r1

DESCRIPTION="Terraform PostgreSQL provider"
HOMEPAGE="https://github.com/cyrilgdn/terraform-provider-postgresql"
SRC_URI="https://github.com/cyrilgdn/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="mirror test"
PROPERTIES="test_network"

RDEPEND="|| ( app-admin/terraform app-admin/opentofu )"
BDEPEND="test? ( ${POSTGRES_DEP}
		app-admin/terraform
		dev-db/dummy_seclabel )"

DOC_CONTENTS="You should create a symlink to\\n
/usr/share/terraform-provider/terraform-provider-proxmox\\n
in ~/.terraform.d/plugins or ~/.opentofu.d/plugins\\n"

src_prepare() {
	default

	has_version ">=dev-db/postgresql-16" && eapply "${FILESDIR}/${PN}"-1.26.0-test-psql16.patch
}

src_compile() {
	ego build
}

src_test() {
	local db="${T}/pgsql"
	export TF_ACC="true" TF_ACC_TERRAFORM_PATH="/usr/bin/terraform" \
		PGHOST="127.0.0.1" PGUSER="postgres" PGSUPERUSER="true" PGSSLMODE="disable"

	edo initdb -U postgres -A trust -D "${db}"
	# test expects UTC timezone, wal_level = logical, max_replication_slots = 10,
	# shared_preload_libraries = 'dummy_seclabel'
	sed -i  -e "/timezone/s|'.*'|'UTC'|" \
		-e '/wal_level/s|replica|logical|' \
		-e '/wal_level/s|^#||' \
		-e '/max_replication_slots/s|^#||' \
		-e "/shared_preload_libraries/s|''|'dummy_seclabel'|" \
		-e '/shared_preload_libraries/s|^#||' \
		"${db}"/postgresql.conf || die "sed for postgresql.conf failed"
	edo pg_ctl -w -D "${db}" start -o "-h '127.0.0.1' -p 5432 -k '${T}'"
	ego test -work ./...
	edo pg_ctl -w -D "${db}" stop
}

src_install() {
	einstalldocs
	exeinto /usr/share/terraform-provider
	doexe terraform-provider-postgresql
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
