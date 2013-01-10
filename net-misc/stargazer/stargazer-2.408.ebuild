# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils linux-info

DESCRIPTION="Stargtazer billing system for small home and office networks"
HOMEPAGE="http://stg.dp.ua/"
MY_P="stg-${PV}"
SRC_URI="http://stg.dp.ua/download/server/${PV}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~sparc"
IUSE="sgconvertor radius rscriptd sgauth sgconf sgconf_xml stargazer debug doc examples static-libs"
MERGE_TYPE="source"

PROJECTS="sgconvertor rlm_stg rscriptd sgauth sgconf sgconf_xml stargazer"
STG_MODULES_AUTH="always_online internet_access freeradius"
STG_MODULES_CAPTURE="ipq ether netflow"
STG_MODULES_CONFIG="sgconfig rpcconfig"
STG_MODULES_OTHER="ping smux remote_script"
STG_MODULES_STORE="files firebird mysql postgres"

for module in ${STG_MODULES_AUTH}; do
	IUSE="${IUSE} module_auth_${module}"
done

for module in ${STG_MODULES_CAPTURE}; do
	IUSE="${IUSE} module_capture_${module}"
done

for module in ${STG_MODULES_CONFIG}; do
	IUSE="${IUSE} module_config_${module}"
done

for module in ${STG_MODULES_OTHER}; do
	IUSE="${IUSE} module_other_${module}"
done

for module in ${STG_MODULES_STORE}; do
	IUSE="${IUSE} module_store_${module}"
done

IUSE=${IUSE/stargazer/+stargazer}
IUSE=${IUSE/module_store_files/+module_store_files}

REQUIRED_USE="
	stargazer? ( ^^ ( module_store_files module_store_firebird module_store_mysql module_store_postgres ) )
"

DEPEND="
	doc? ( dev-libs/libxslt )
	sgconf? ( dev-libs/expat )
	sgconf_xml? ( dev-libs/expat )
	module_config_rpcconfig? ( dev-libs/xmlrpc-c[abyss]
				sys-libs/zlib )
	module_config_sgconfig? ( dev-libs/expat )
	module_store_firebird? ( >=dev-db/firebird-2.0.3.12981.0-r6 )
	module_store_mysql? ( dev-db/mysql )
	module_store_postgres? ( dev-db/postgresql-base
				sys-libs/zlib
				dev-libs/openssl )
"

src_prepare() {
	# Patches already in upstream's trunk
	# Rename convertor to sgconvertor to avoid possible file name collisions
	mv "${S}"/projects/convertor/ "${S}"/projects/sgconvertor/
	mv "${S}"/projects/sgconvertor/convertor.conf "${S}"/projects/sgconvertor/sgconvertor.conf
	epatch "${FILESDIR}"/patches/stg-2.408-sgconvertor-upstream.patch
	# Fix dependency on fbclient for module_store_firebird
	epatch "${FILESDIR}"/patches/stg-2.408-makefile-firebird-upstream.patch
	# Option to keep symbol table on debug and create full path on install for all projects. Install/uninstall targer for sgconvertor
	epatch "${FILESDIR}"/patches/stg-2.408-makefile-upstream.patch
	# Run make automatically on debug for stargazer. Don't compile sgconvertor always with debug. Remove MAKEOPTS=-j1.
	epatch "${FILESDIR}"/patches/stg-2.408-build-upstream.patch
	# Rewrite config for rscriptd
	epatch "${FILESDIR}"/patches/stg-2.408-rscriptd.conf-upstream.patch
	# Rewrite config for sgauth
	epatch "${FILESDIR}"/patches/stg-2.408-sgauth.conf-upstream.patch
	# Standardization of 'On-scripts'
	epatch "${FILESDIR}"/patches/stg-2.408-on-upstream.patch

	for project in ${PROJECTS}; do
		# Rename build script to configure for further econf launch in every projects
		mv "${S}"/projects/${project}/build "${S}"/projects/${project}/configure
		# Change check for debug build
		sed -i 's/if \[ "$1" = "debug" \]/if \[ "${10}" = "--enable-debug" \]/' "${S}"/projects/${project}/configure
	done

	# Correct working directory, user and group
	epatch "${FILESDIR}"/patches/stg-2.408-sgconvertor.conf.patch
	# Correct path for files and directories
	epatch "${FILESDIR}"/patches/stg-2.408-rscriptd.conf.patch
	# Correct working directory, user and group
	epatch "${FILESDIR}"/patches/stg-2.408-store_files.conf.patch
	# Correct path for file
	epatch "${FILESDIR}"/patches/stg-2.408-store_firebird.conf.patch
	# Correct path for file
	epatch "${FILESDIR}"/patches/stg-2.408-mod_remote_script.conf.patch
	# Correct path and user for file
	epatch "${FILESDIR}"/patches/stg-2.408-00-base-00.sql.patch
	# Correct paths
	epatch "${FILESDIR}"/patches/stg-2.408-stargazer.conf.patch
	# Correct paths
	epatch "${FILESDIR}"/patches/stg-2.408-rpcconfig.cpp.patch
	# Correct target install-data for stargazer
	epatch "${FILESDIR}"/patches/stg-2.408-makefile-stargazer.patch
	# Correct paths for rscriptd
	epatch "${FILESDIR}"/patches/stg-2.408-makefile-rscriptd.patch
	# Correct paths for sgauth
	epatch "${FILESDIR}"/patches/stg-2.408-makefile-sgauth.patch
	# Remove make from script (for keeping symbol table if needed), always add variables to Makefile.conf
	epatch "${FILESDIR}"/patches/stg-2.408-build.patch

	# Define which module to compile
	use module_auth_always_online	|| sed -i 's/authorization\/ao//' "${S}"/projects/stargazer/configure
	use module_auth_internet_access	|| sed -i 's/authorization\/inetaccess//' "${S}"/projects/stargazer/configure
	use module_auth_freeradius	|| sed -i 's/other\/radius//' "${S}"/projects/stargazer/configure
	use module_capture_ipq		|| sed -i 's/capture\/ipq_linux//' "${S}"/projects/stargazer/configure
	use module_capture_ether	|| sed -i 's/capture\/ether_linux//' "${S}"/projects/stargazer/configure
	use module_capture_netflow	|| sed -i 's/capture\/cap_nf//' "${S}"/projects/stargazer/configure
	use module_config_sgconfig	|| sed -i 's/configuration\/sgconfig//' "${S}"/projects/stargazer/configure
	use module_config_rpcconfig	|| sed -i 's/configuration\/rpcconfig//' "${S}"/projects/stargazer/configure
	use module_other_ping		|| sed -i 's/other\/ping//' "${S}"/projects/stargazer/configure
	use module_other_smux		|| sed -i 's/other\/smux//' "${S}"/projects/stargazer/configure
	use module_other_remote_script	|| sed -i 's/other\/rscript//' "${S}"/projects/stargazer/configure
	use module_store_files		|| sed -i 's/store\/files//' "${S}"/projects/stargazer/configure
	use module_store_firebird	|| sed -i 's/store\/firebird//' "${S}"/projects/stargazer/configure
	use module_store_mysql		|| sed -i 's/store\/mysql//' "${S}"/projects/stargazer/configure
	use module_store_postgres	|| sed -i 's/store\/postgresql//' "${S}"/projects/stargazer/configure
	# Correct Gentoo init script provided by upstream (TODO: Remove in further releases, already fixed in upstream's trunk)
	use stargazer			&& sed -i 's/opts/extra_commands/' "${S}"/projects/stargazer/inst/linux/etc/init.d/stargazer.gentoo
	# Correct Gentoo init script dependencies
	use module_store_files		&& sed -i '11d' "${S}"/projects/stargazer/inst/linux/etc/init.d/stargazer.gentoo
	use module_store_firebird	&& sed -i '11d;s/need net/need net firebird/' "${S}"/projects/stargazer/inst/linux/etc/init.d/stargazer.gentoo
	use module_store_mysql		&& sed -i '11d;s/need net/need net mysql/' "${S}"/projects/stargazer/inst/linux/etc/init.d/stargazer.gentoo
	use module_store_postgres	&& sed -i '11d;s/need net/need net postgresql/' "${S}"/projects/stargazer/inst/linux/etc/init.d/stargazer.gentoo
	# Check for IPQ subsystem availability
	( use module_capture_ipq && kernel_is ge 3 5 ) && die "IPQ subsystem is gone since Linux kernel 3.5. You can't compile module_capture_ipq with your current kernel."
}

src_configure() {
	# Define local variables, strip '+' symbol for used by default USE flags
	local USEFLAGS=(${IUSE//+})
	local PROJECTS=($PROJECTS)

	for (( i = 0 ; i < ${#PROJECTS[@]} ; i++ )); do
		if use ${USEFLAGS[$i]} ; then
			cd "${S}"/projects/${PROJECTS[$i]} || die "cd to ${PROJECTS[$i]} failed"
			# Call configure
			econf $(use_enable debug)
			# Set jobs to 1 for debug build
			use debug && MAKEOPTS="-j1"
			# Call make
			emake
		fi
	done
}

pkg_setup() {
	# Add user and group to system only when necessary
	if use sgconvertor || use rscriptd || use sgauth || use stargazer ; then
		# Add stg group to system
		enewgroup stg
		# Add stg user to system (no home directory specified, because otherwise it will be result in stg:root ownership on it)
		enewuser stg -1 -1 -1 stg
	fi
}

pkg_postinst() {
	if use sgconvertor; then
		einfo "Sgconvertor:"
		einfo "----------"
		einfo "    For further use of sgconvertor please edit /etc/stargazer/sgconvertor.conf depending on your needs."
	fi

	if use radius; then
		einfo "\nRadius:"
		einfo "-------"
		einfo "    For further use of radius, install net-dialup/freeradius:\n"
		einfo "      # emerge -atv net-dialup/freeradius\n"
		einfo "    Example config:\n"
		einfo "        stg {"
		einfo "               local_port = 6667"
		einfo "               server = localhost"
		einfo "               port = 6666"
		einfo "               password = 123456"
		einfo "        }\n"
		einfo "    You should place 'stg' into section Instantiate, Authorize."
		einfo "    In section Authentificate 'stg' should go in sub-section Auth-Type before other authentifications modules:\n"
		einfo "        Auth-Type PAP {"
		einfo "                         stg"
		einfo "                         pap"
		einfo "        }\n"
		einfo "    It also may be used in section Accounting and Post-Auth."
		use module_auth_freeradius || einfo "    For use RADIUS data processing you should also enable USE-flag module_auth_freeradius."
	fi

	if use rscriptd; then
		einfo "\nRemote Script Executer:"
		einfo "-----------------------"
		einfo "    For further use of rscriptd please edit /etc/stargazer/rscriptd.conf depending on your needs."
		einfo "    You have to change 'Password' field at least."
	fi

	if use sgauth; then
		einfo "\nSgauth:"
		einfo "-------"
		einfo "    For further use of sgauth please edit /etc/stargazer/sgauth.conf depending on your needs."
		einfo "    You have to change 'ServerName', 'Login', 'Password' fields at least."
	fi

	if use sgconf; then
		einfo "\nSgconf:"
		einfo "-------"
		use module_config_sgconfig || einfo "    For further use of sgconf utility you should also enable USE-flag module_config_sgconfig."
	fi

	if use sgconf_xml; then
		einfo "\nSgconf_xml:"
		einfo "-----------"
		use module_config_rpcconfig || einfo "    For further use of sgconf_xml utility you should also enable USE-flag module_config_rpcconfig."
	fi

	if use stargazer; then
		einfo "\nStargazer:"
		einfo "----------"
		einfo "    Modules availability:"
		if use module_auth_always_online; then
			einfo "      * module_auth_always_online available."
		fi
		if use module_auth_internet_access; then
			einfo "      * module_auth_internet_access available."
		fi
		if use module_auth_freeradius; then
			einfo "      * module_auth_freeradius available."
			einfo "           For further use of module, install net-dialup/freeradius:\n"
			einfo "             # emerge -atv net-dialup/freeradius\n"
			use radius || einfo "\n           For use RADIUS data processing you should also enable use USE-flag radius."
		fi
		if use module_capture_ipq; then
			einfo "      * module_capture_ipq available."
		fi
		if use module_capture_ether; then
			einfo "      * module_capture_ether available."
		fi
		if use module_capture_netflow; then
			einfo "      * module_capture_netflow available."
			einfo "           For further use of module, install net-firewall/ipt_netflow or net-analyzer/softflowd:\n"
			einfo "             # emerge -atv net-firewall/ipt_netflow or emerge -atv net-analyzer/softflowd\n"
		fi
		if use module_config_sgconfig; then
			einfo "      * module_config_sgconfig available."
			fi
		if use module_config_rpcconfig; then
			einfo "      * module_config_rpcconfig available."
			einfo "           KNOWN BUG: Sometimes you can't configure Stargazer through xml-based configurator,"
			einfo "                      because module is not responding."
			einfo "                      This bug is introduced by xmlrpc-c library. This bug proceeds very rare, but it still exists."
		fi
		if use module_other_ping; then
			einfo "      * module_other_ping available."
		fi
		if use module_other_smux; then
			einfo "      * module_other_smux available."
			einfo "           For further use of module install net-analyzer/net-snmp:\n"
			einfo "             # emerge -atv net-analyzer/net-snmp\n"
		fi
		if use module_other_remote_script; then
			einfo "      * module_other_remote_script available."
			einfo "           Don't forget to edit /etc/stargazer/subnets file depending on your needs."
		fi
		if use module_store_files; then
			einfo "      * module_store_files available."
			einfo "           Necessary and sufficient rights to the directory /var/lib/stargazer for this backend is 0755."
			einfo "           You may fix it if needed."
		fi
		if use module_store_firebird; then
			einfo "      * module_store_firebird available."
			einfo "           Necessary and sufficient rights to the directory /var/lib/stargazer for this backend is 0775."
			einfo "           Check that it was so, and fix it if needed."
			einfo "           You should add 'firebird' user to stg group:\n"
			einfo "             # usermod -a -G stg firebird\n"
			einfo "           and restart firebird:\n"
			einfo "             # /etc/init.d/firebird restart\n"
			einfo "           Stargazer DB schema for Firebird is here: /usr/share/stargazer/db/firebird"
			einfo "           For new setup you should execute 00-base-00.sql:\n"
			einfo "             # fbsql -q -i /usr/share/stargazer/db/firebird/00-base-00.sql\n"
			einfo "           For upgrade from version 2.406 you should execute 00-alter-01.sql:\n"
			einfo "             # fbsql -q -u <username> -p <password> -d <database> -i /usr/share/stargazer/db/firebird/00-alter-01.sql\n"
		fi
		if use module_store_mysql; then
			einfo "      * module_store_mysql available."
			einfo "           For upgrade from version 2.406 you should execute 00-mysql-01.sql:\n"
			einfo "             # mysql -h <hostname> -P <port> -u <username> -p <password> <database> < /usr/share/stargazer/db/mysql/00-mysql-01.sql\n"
		fi
		if use module_store_postgres; then
			einfo "      * module_store_postgres available."
			einfo "           Stargazer DB schema for PostgresSQL is here: /usr/share/stargazer/db/postgresql"
			einfo "           For new setup you should execute 00-base-00.postgresql.sql:\n"
			einfo "             # psql -h <hostname> -p <port> -U <username> -d <database> -W -f /usr/share/stargazer/db/postgresql/00-base-00.postgresql.sql\n"
			einfo "           For upgrade from version 2.406 you should execute 00-alter-01.sql:\n"
			einfo "             # psql -h <hostname> -p <port> -U <username> -d <database> -W -f /usr/share/stargazer/db/postgresql/00-alter-01.sql\n"
		fi
		einfo "    For all storage backends:"
		einfo "      Default admin login - admin, default admin password - 123456."
		einfo "      Default subscriber login - test, default subscriber password - 123456.\n"
		einfo "Don't upgrade to newer version without reading ChangeLog,"
		einfo "it can be found in /usr/share/doc/${PF}\n"
	fi
	if use debug; then
		ewarn "  This is debug build. You should avoid to use it in production.\n"
	fi
}

src_install() {
	# Install changelog
	dodoc ChangeLog

	if use rscriptd || use stargazer ; then
		# Install config file for logrotate
		insinto /etc/logrotate.d
		newins "${FILESDIR}"/logrotate stargazer
		# Keeping logs directory
		diropts -m 755 -o stg -g stg
		keepdir /var/log/stargazer
		if use stargazer; then
			diropts -m 775 -o stg -g stg
			keepdir /var/lib/stargazer
		fi
	fi

	if use doc; then
		# Install files into docs directory
		dodoc "${S}"/projects/stargazer/inst/var/base.dia
		dodoc "${S}"/doc/proto_client.gif
		dodoc "${S}"/doc/proto_server.gif
		# Change current directory
		cd "${S}"/doc/xmlrpc
		# Compile html documentation
		emake
		# Install html documentation
		docinto html/xmlrpc
		dohtml -r "${S}"/doc/xmlrpc/book/
	fi

	if use examples; then
		# Install files into specified directory
		insinto /usr/share/stargazer
		doins -r "${S}"/projects/stargazer/scripts
		doins "${S}"/doc/xmlrpc.php
	fi

	if use sgconvertor; then
		# Change current directory
		cd "${S}"/projects/sgconvertor
		# Call make install
		emake DESTDIR="${D}" PREFIX="${D}" install
		# Install files into specified directory
		insinto /etc/stargazer
		doins "${S}"/projects/sgconvertor/sgconvertor.conf
		# Install manual page
		doman "${FILESDIR}"/mans/sgconvertor.1
	fi

	if use radius; then
		# Change current directory
		cd "${S}"/projects/rlm_stg
		# Call make install
		emake DESTDIR="${D}" PREFIX="${D}" install
	fi

	if use rscriptd; then
		# Change current directory
		cd "${S}"/projects/rscriptd
		# Call make install
		emake DESTDIR="${D}" PREFIX="${D}" install
		# Install Gentoo init script
		doinitd "${FILESDIR}"/rscriptd
		# Correct permissions for file
		fperms 0640 /etc/stargazer/rscriptd.conf
		# Install manual page
		doman "${FILESDIR}"/mans/rscriptd.8
	fi

	if use sgauth; then
		# Change current directory
		cd "${S}"/projects/sgauth
		# Call make install
		emake DESTDIR="${D}" PREFIX="${D}" install
		# Correct permissions for file
		fperms 0640 /etc/stargazer/sgauth.conf
		# Install manual page
		doman "${FILESDIR}"/mans/sgauth.8
	fi

	if use sgconf; then
		# Change current directory
		cd "${S}"/projects/sgconf
		# Call make install
		emake DESTDIR="${D}" PREFIX="${D}" install
		# Install manual page
		doman "${FILESDIR}"/mans/sgconf.1
	fi

	if use sgconf_xml; then
		# Change current directory
		cd "${S}"/projects/sgconf_xml
		# Call make install
		emake DESTDIR="${D}" PREFIX="${D}" install
		# Install manual page
		doman "${FILESDIR}"/mans/sgconf_xml.1
	fi

	if use stargazer; then
		# Change current directory
		cd "${S}"/projects/stargazer
		# Call make install
		emake DESTDIR="${D}" PREFIX="${D}" install
		# Install docs
		dodoc BUGS CHANGES README TODO
		# Install and rename Gentoo init script
		newinitd "${S}"/projects/stargazer/inst/linux/etc/init.d/stargazer.gentoo stargazer
		# Install manual page
		doman "${FILESDIR}"/mans/stargazer.8
		# Install files needed for module_store_files
		if use module_store_files; then
			# Install files into specified directory
			insinto /var/lib
			doins -r "${S}"/projects/stargazer/inst/var/stargazer
			# Correct user and group for files and directories
			fowners -R stg:stg /var/lib/stargazer
		fi
		if use module_store_firebird; then
			# Install files into specified directory
			insinto /usr/share/stargazer/db/firebird
			doins \
				"${S}"/projects/stargazer/inst/var/00-base-00.sql \
				"${S}"/projects/stargazer/inst/var/00-alter-01.sql
		fi
		if use module_store_mysql; then
			# Install file into specified directory
			insinto /usr/share/stargazer/db/mysql
			doins "${S}"/projects/stargazer/inst/var/00-mysql-01.sql
		fi
		if use module_store_postgres; then
			# Install files into specified directory
			insinto /usr/share/stargazer/db/postgresql
			doins \
				"${S}"/projects/stargazer/inst/var/00-base-00.postgresql.sql \
				"${S}"/projects/stargazer/inst/var/00-alter-01.postgresql.sql
		fi
		if use module_other_smux; then
			# Install files into specified directory
			insinto /usr/share/snmp/mibs
			doins "${S}"/projects/stargazer/plugins/other/smux/STG-MIB.mib
		fi
		if use module_other_remote_script; then
			# Create subnets file based on example from mod_remote_script.conf
			grep 192 "${S}"/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/mod_remote_script.conf | sed 's/# //' > "${D}"/etc/stargazer/subnets
			# Correct permissions for file
			fperms 0640 /etc/stargazer/subnets
		fi
		# Correct permissions for files
		fperms 0640 \
			/etc/stargazer/rules \
			/etc/stargazer/stargazer.conf
		# Install files into specified directory for selected modules
		insinto /etc/stargazer/conf-available.d
		insopts -m 0640
		use module_auth_always_online	&& doins "${S}"/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/mod_ao.conf
		use module_auth_internet_access	&& doins "${S}"/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/mod_ia.conf
		use module_auth_freeradius	&& doins "${S}"/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/mod_radius.conf
		use module_capture_ipq		&& doins "${S}"/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/mod_cap_ipq.conf
		use module_capture_ether	&& doins "${S}"/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/mod_cap_ether.conf
		use module_capture_netflow	&& doins "${S}"/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/mod_cap_nf.conf
		use module_config_sgconfig	&& doins "${S}"/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/mod_sg.conf
		use module_config_rpcconfig	&& doins "${S}"/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/mod_rpc.conf
		use module_other_ping		&& doins "${S}"/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/mod_ping.conf
		use module_other_smux		&& doins "${S}"/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/mod_smux.conf
		use module_other_remote_script	&& doins "${S}"/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/mod_remote_script.conf
		use module_store_files		&& doins "${S}"/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/store_files.conf
		use module_store_firebird	&& doins "${S}"/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/store_firebird.conf
		use module_store_mysql		&& doins "${S}"/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/store_mysql.conf
		use module_store_postgres	&& doins "${S}"/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/store_postgresql.conf
		# Create symlinks of configs for selected modules
		use module_auth_always_online	&& dosym /etc/stargazer/conf-available.d/mod_ao.conf		/etc/stargazer/conf-enabled.d/mod_ao.conf
		use module_auth_internet_access	&& dosym /etc/stargazer/conf-available.d/mod_ia.conf		/etc/stargazer/conf-enabled.d/mod_ia.conf
		use module_auth_freeradius	&& dosym /etc/stargazer/conf-available.d/mod_radius.conf	/etc/stargazer/conf-enabled.d/mod_radius.conf
		use module_capture_ipq		&& dosym /etc/stargazer/conf-available.d/mod_cap_ipq.conf	/etc/stargazer/conf-enabled.d/mod_cap_ipq.conf
		use module_capture_ether	&& dosym /etc/stargazer/conf-available.d/mod_cap_ether.conf	/etc/stargazer/conf-enabled.d/mod_cap_ether.conf
		use module_capture_netflow	&& dosym /etc/stargazer/conf-available.d/mod_cap_nf.conf	/etc/stargazer/conf-enabled.d/mod_cap_nf.conf
		use module_config_sgconfig	&& dosym /etc/stargazer/conf-available.d/mod_sg.conf		/etc/stargazer/conf-enabled.d/mod_sg.conf
		use module_config_rpcconfig	&& dosym /etc/stargazer/conf-available.d/mod_rpc.conf		/etc/stargazer/conf-enabled.d/mod_rpc.conf
		use module_other_ping		&& dosym /etc/stargazer/conf-available.d/mod_ping.conf		/etc/stargazer/conf-enabled.d/mod_ping.conf
		use module_other_smux		&& dosym /etc/stargazer/conf-available.d/mod_smux.conf		/etc/stargazer/conf-enabled.d/mod_smux.conf
		use module_other_remote_script	&& dosym /etc/stargazer/conf-available.d/mod_remote_script.conf	/etc/stargazer/conf-enabled.d/mod_remote_script.conf
		use module_store_files		&& dosym /etc/stargazer/conf-available.d/store_files.conf	/etc/stargazer/conf-enabled.d/store_files.conf
		use module_store_firebird	&& dosym /etc/stargazer/conf-available.d/store_firebird.conf	/etc/stargazer/conf-enabled.d/store_firebird.conf
		use module_store_mysql		&& dosym /etc/stargazer/conf-available.d/store_mysql.conf	/etc/stargazer/conf-enabled.d/store_mysql.conf
		use module_store_postgres	&& dosym /etc/stargazer/conf-available.d/store_postgresql.conf	/etc/stargazer/conf-enabled.d/store_postgresql.conf
	fi
	# Correct user and group for files and directories
	( use sgconvertor || use rscriptd || use sgauth || use stargazer ) && fowners -R stg:stg /etc/stargazer
	# Remove static libs if USE flag is not selected
	use static-libs || find "${D}" -name '*.a' -exec rm -f {} +
}
