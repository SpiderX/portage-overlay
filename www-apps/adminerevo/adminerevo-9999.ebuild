# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2317

EAPI=8

PLOCALES="ar bg bn bs ca cs da de el en es et fa fi fr gl he hu id it ja ka ko lt lv ms nl no pl pt-br pt ro ru sk sl sr sv ta th tr uk vi zh zh-tw"
PLOCALE_BACKUP="en"
EGIT_REPO_URI="https://github.com/adminerevo/${PN}.git"

inherit edo git-r3 plocale webapp

declare -A DRIVERS
DRIVERS=( [elasticsearch]="elastic"
	[mongodb]="mongo"
	[mssql]="mssql"
	[oracle]="oracle"
	[postgres]="pgsql"
	[sqlite]="sqlite"
)

PLUGIN_DRIVERS="clickhouse firebird simpledb"
PLUGINS="adminer-js dump-bz2 dump-zip enum-option import-from-dir login-password-less struct-comments translation
	database-hide dump-date edit-calendar enum-types json-column login-servers pretty-json-column
	table-indexes-structure version-noverify designs dump-json edit-foreign file-upload login-external
	login-ssl tables-filter wymeditor dump-php edit-textarea foreign-system login-ip login-table slugify
	table-structure dump-alter dump-xml email-table frames login-otp master-slave sql-log tinymce"
DESIGNS="brade cvicebni-ubor esterka galkaev hever jukin konya mancave mvt ng9 pappu687 pepa-linha pilot price rmsoft
	bueltge dracula flat haeckel hydra kahi lucas-sandery mancave-hever nette nicu paranoiq pepa-linha-dark pokorny
	rmsoft-blue"

DESCRIPTION="Database management in a single PHP file"
HOMEPAGE="https://github.com/adminerevo/adminerevo"

LICENSE="Apache-2.0"
IUSE="design editor +mysql oci8-instant-client pdo plugin"
REQUIRED_USE="mysql adminer-js? ( plugin ) dump-bz2? ( plugin ) dump-zip? ( plugin ) enum-option? ( plugin )
	import-from-dir? ( plugin ) login-password-less? ( plugin ) struct-comments? ( plugin )
	translation? ( plugin ) database-hide? ( plugin ) dump-date? ( plugin ) edit-calendar? ( plugin )
	enum-types? ( plugin ) json-column? ( plugin ) login-servers? ( plugin ) pretty-json-column? ( plugin )
	table-indexes-structure? ( plugin ) version-noverify? ( plugin ) designs? ( plugin ) dump-json? ( plugin )
	edit-foreign? ( plugin ) file-upload? ( plugin ) login-external? ( plugin ) login-ssl? ( plugin )
	tables-filter? ( plugin ) wymeditor? ( plugin ) dump-php? ( plugin ) edit-textarea? ( plugin )
	foreign-system? ( plugin ) login-ip? ( plugin ) login-table? ( plugin ) slugify? ( plugin )
	table-structure? ( plugin ) dump-alter? ( plugin ) dump-xml? ( plugin ) email-table? ( plugin )
	frames? ( plugin ) login-otp? ( plugin ) master-slave? ( plugin ) sql-log? ( plugin ) tinymce? ( plugin )
	firebird? ( pdo ) mongodb? ( pdo ) elasticsearch? ( pdo ) clickhouse? ( pdo ) oracle? ( oci8-instant-client )
	simpledb? ( pdo )"

for driver in "${!DRIVERS[@]}" ; do IUSE="${IUSE} ${driver}" ; done
for plugin_driver in ${PLUGIN_DRIVERS} ; do IUSE="${IUSE} ${plugin_driver}" ; done
for plugin in ${PLUGINS} ; do IUSE="${IUSE} ${plugin}" ; done
for design in ${DESIGNS} ; do IUSE="${IUSE} ${design}" ; done

CDEPEND="dev-lang/php[firebird?,mssql?,postgres?,sqlite?,pdo?,session]"
RDEPEND="firebird? ( dev-db/firebird )
	postgres? ( dev-db/postgresql:= )
	sqlite? ( dev-db/sqlite:3 )
	${CDEPEND}"
BDEPEND="${CDEPEND}"

DOCS=( {README,PLUGINS}.md )

src_prepare() {
	default

	mv plugins/adminer{.,-}js.php || die "mv for adminer.js.php failed"
	mv rmsoft{_,-}blue || die "mv for rmsoft_blue failed"

	my_rm_loc() {
		sed -i "/'${1}' =>/d" adminer/include/lang.inc.php || die "sed failed for lang.inc.php"
	}
	plocale_for_each_disabled_locale my_rm_loc

	local driver
	for driver in "${!DRIVERS[@]}" ; do
		if ! use "$driver" ; then
			sed -i "/adminer\/drivers\/${DRIVERS[$driver]}/d" adminer/include/bootstrap.inc.php \
				|| die "sed failed for bootstrap.inc.php"
			rm adminer/drivers/"${DRIVERS[$driver]}".inc.php || die "rm for driver failed"
		fi
	done
}

src_compile() {
	edo php compile.php
	use editor && edo php compile.php editor
}

src_install() {
	einstalldocs
	webapp_src_preinst

	if use clickhouse || use firebird || use simpledb ; then
		insinto "${MY_HTDOCSDIR}"/plugins/drivers
		use clickhouse && doins plugins/drivers/clickhouse.php
		use firebird && doins plugins/drivers/firebird.php
		use simpledb && doins plugins/drivers/simpledb.php
	fi

	if use plugin ; then
		insinto "${MY_HTDOCSDIR}"/plugins
		doins plugins/plugin.php
		for plugin in ${PLUGINS} ; do
			use "$plugin" && doins plugins/"$plugin".php
		done
	fi

	if use design ; then
		insinto "${MY_HTDOCSDIR}"
		for design in ${DESIGNS} ; do
			use "$design" && doins designs/"$design"/adminer.css
		done
	fi

	insinto "${MY_HTDOCSDIR}"
	newins adminer-4.8.4.php adminer.php
	use editor && newins editor-4.8.4.php editor.php
	webapp_src_install
}
