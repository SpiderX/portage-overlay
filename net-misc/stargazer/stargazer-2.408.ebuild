# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils linux-info

DESCRIPTION="Stargtazer billing system for small home and office networks"
HOMEPAGE="http://stg.dp.ua/"
MY_P="stg-${PV}"
SRC_URI="http://stg.dp.ua/download/server/${PV}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 sparc"
IUSE="convertor radius rscriptd sgauth sgconf xmlrpc stargazer debug doc examples static-libs"
MERGE_TYPE="source"

PROJECTS="convertor rlm_stg rscriptd sgauth sgconf sgconf_xml stargazer"
MODULES_AUTH="always_online internet_access freeradius"
MODULES_CAPTURE="ipq ether netflow"
MODULES_CONFIG="sgconfig rpcconfig"
MODULES_OTHER="ping smux remote_script"
MODULES_STORE="files firebird mysql postgres"

for module in ${MODULES_AUTH}; do
        IUSE="${IUSE} module_auth_${module}"
done

for module in ${MODULES_CAPTURE}; do
        IUSE="${IUSE} module_capture_${module}"
done

for module in ${MODULES_CONFIG}; do
        IUSE="${IUSE} module_config_${module}"
done

for module in ${MODULES_OTHER}; do
        IUSE="${IUSE} module_other_${module}"
done

for module in ${MODULES_STORE}; do
        IUSE="${IUSE} module_store_${module}"
done

IUSE=${IUSE/stargazer/+stargazer}
IUSE=${IUSE/module_store_files/+module_store_files}

REQUIRED_USE="stargazer? ( || ( module_store_files module_store_firebird module_store_mysql module_store_postgres ) )"

DEPEND="
	sgconf? ( dev-libs/expat )
	xmlrpc? ( dev-libs/expat )
	module_config_rpcconfig? ( dev-libs/xmlrpc-c[abyss]
				sys-libs/zlib )
	module_config_sgconfig? ( dev-libs/expat )
	module_store_firebird? ( dev-db/firebird )
	module_store_mysql? ( dev-db/mysql )
	module_store_postgres? ( dev-db/postgresql-base
				sys-libs/zlib
				dev-libs/openssl )
"

src_prepare() {
	for project in ${PROJECTS}; do
		# Rename build script to configure for further econf launch in every projects
		mv ${S}/projects/${project}/build ${S}/projects/${project}/configure
		if (( ( ${project} == "stargazer" ) || ( ${project} == "rscriptd" ) || ( ${project} == "sgauth" ) || ( ${project} == "sgconf_xml" ) )); then
			# Remove target install-data
			sed -i 's/install: install-bin install-data/install: install-bin/' ${S}/projects/${project}/Makefile
			# Remove binary file install target
			sed -i 's/install -m $(BIN_MODE) -o $(OWNER) -s $(PROG) $(PREFIX)\/usr\/sbin\/$(PROG)//' ${S}/projects/${project}/Makefile
		fi
		# Remove binary file install target
		[ ${project} == "rlm_stg" ] && sed -i 's/install -m $(BIN_MODE) -o $(OWNER) -s $(PROG) $(PREFIX)\/usr\/lib\/$(PROG)//' ${S}/projects/${project}/Makefile
		[ ${project} == "sgconf" ] && sed -i 's/install -m $(BIN_MODE) -o $(OWNER) -s $(PROG) $(PREFIX)\/usr\/sbin\/$(PROG)//' ${S}/projects/${project}/Makefile
	done
	
	# Correct working directory, user and group
	epatch "${FILESDIR}"/convertor.conf.patch
	# Correct path for files and directories
	epatch "${FILESDIR}"/rscriptd.conf.patch
	# Correct working directory, user and group
	epatch "${FILESDIR}"/store_files.conf.patch
	# Correct path for file
	epatch "${FILESDIR}"/store_firebird.conf.patch
	# Correct path for file
	epatch "${FILESDIR}"/mod_remote_script.conf.patch
	
	# Define which module to compile
	use module_auth_always_online	|| sed -i 's/authorization\/ao//' ${S}/projects/stargazer/configure
	use module_auth_internet_access	|| sed -i 's/authorization\/inetaccess//' ${S}/projects/stargazer/configure
	use module_auth_freeradius	|| sed -i 's/other\/radius//' ${S}/projects/stargazer/configure
	use module_capture_ipq		|| sed -i 's/capture\/ipq_linux//' ${S}/projects/stargazer/configure
	use module_capture_ether	|| sed -i 's/capture\/ether_linux//' ${S}/projects/stargazer/configure
	use module_capture_netflow	|| sed -i 's/capture\/cap_nf//' ${S}/projects/stargazer/configure
	use module_config_sgconfig	|| sed -i 's/configuration\/sgconfig//' ${S}/projects/stargazer/configure
	use module_config_rpcconfig	|| sed -i 's/configuration\/rpcconfig//' ${S}/projects/stargazer/configure
	use module_other_ping		|| sed -i 's/other\/ping//' ${S}/projects/stargazer/configure
	use module_other_smux		|| sed -i 's/other\/smux//' ${S}/projects/stargazer/configure
	use module_other_remote_script	|| sed -i 's/other\/rscript//' ${S}/projects/stargazer/configure
	use module_store_files		|| sed -i 's/store\/files//' ${S}/projects/stargazer/configure
	use module_store_firebird	|| sed -i 's/store\/firebird//' ${S}/projects/stargazer/configure
	use module_store_mysql		|| sed -i 's/store\/mysql//' ${S}/projects/stargazer/configure
	use module_store_postgres	|| sed -i 's/store\/postgresql//' ${S}/projects/stargazer/configure
	# Correct Gentoo init script provided by upstream (TODO: Remove in further releases, already fixed in upstream's trunk)
	use stargazer			&& sed -i 's/opts/extra_commands/' ${S}/projects/stargazer/inst/linux/etc/init.d/stargazer.gentoo
	# Check for ip_queue.h availability
	if use module_capture_ipq; then
		if kernel_is ge 3 5; then
			if [ ! -r /usr/include/linux/netfilter_ipv4/ip_queue.h ]; then
				die "ip_queue.h is gone since Linux kernel 3.5. It is provided now by netfilter/iptables package. You should get it by yourself."
			fi
		fi
	fi
}

src_configure() {
	# Define local variables, strip '+' symbol for used by default USE flags
	local USEFLAGS=(${IUSE//+})
	local PROJECTS=($PROJECTS)
	
	# Call configure in selected projects directory
	for (( i = 0 ; i < ${#PROJECTS[@]} ; i++ )); do
		if use ${USEFLAGS[$i]} ; then
			cd ${S}/projects/${PROJECTS[$i]} || die "cd to ${PROJECTS[$i]} failed"
			econf
		fi
	done
}

pkg_setup() {
	# Add stg group to system
	enewgroup stg
	# Add stg user to system
	enewuser stg -1 -1 /var/lib/stargazer stg
}

pkg_postinst() {
	if use convertor; then
		elog ""
	fi
	if use 	module_other_smux; then
		elog "For use smux install net-analyzer/net-snmp[smux] "
	fi
	if use module_auth_freeradius; then
		elog "For use rlm_stg.so install net-dialup/freeradius "
	fi
	elog " Default user - admin, default pass - 123456."
}

src_install() {
	# Install changelog
	dodoc ChangeLog
	# Create necessary directories
	dodir \
		/usr/share/stargazer/db \
		/usr/share/stargazer/db/mysql \
		/usr/share/stargazer/db/postgresql
	# Keeping home directory for stg user
	keepdir \
		/var/lib/stargazer \
		/var/log/stargazer
	# Install files into specified directory
	insinto /usr/share/stargazer/db
	doins \
		${S}/projects/stargazer/inst/var/00-base-00.sql \
		${S}/projects/stargazer/inst/var/00-alter-01.sql
	# Install file into specified directory
	insinto /usr/share/stargazer/db/mysql
	doins ${S}/projects/stargazer/inst/var/00-mysql-01.sql
	# Install files into specified directory
	insinto /usr/share/stargazer/db/postgresql
	doins \
		${S}/projects/stargazer/inst/var/00-base-00.postgresql.sql \
		${S}/projects/stargazer/inst/var/00-alter-01.postgresql.sql
	
	if use doc; then
		# Install file into specified directory
		insinto /usr/share/stargazer/db
		doins ${S}/projects/stargazer/inst/var/base.dia
	fi
	
	if use examples; then
		# Install files into specified directory
		insinto /usr/share/stargazer
		doins -r ${S}/projects/stargazer/scripts
	fi
	
	if use convertor; then
		# Install convertor binnary file to /usr/bin
		dobin ${S}/projects/convertor/convertor
		# Install files into specified directory
		insinto /etc/stargazer
		doins ${S}/projects/convertor/convertor.conf
		# Correct permissions for file
		fperms 0640 /etc/stargazer/convertor.conf
	fi
	
	if use radius; then
		# Change current directory
		cd ${S}/projects/rlm_stg
		# Call make install
		emake DESTDIR="${D}" PREFIX="${D}" install
		# Install file into specified directory
		insinto /usr/lib/freeradius
		doins rlm_stg.so
		# Correct permissions for file
		fperms 0755 /usr/lib/freeradius/rlm_stg.so
	fi
	
	if use rscriptd; then
		# Change current directory
		cd ${S}/projects/rscriptd
		# Call make install
		emake DESTDIR="${D}" PREFIX="${D}" install
		# Install rscriptd binnary file to /usr/sbin
		dosbin rscriptd
		# Install file into specified directory
		insinto /etc/stargazer
		doins rscriptd.conf
		# Correct permissions for file
		fperms 0640 /etc/stargazer/rscriptd.conf
	fi
	
	if use sgauth; then
		# Change current directory
		cd ${S}/projects/sgauth
		# Call make install
		emake DESTDIR="${D}" PREFIX="${D}" install
		# Install sgauth binnary file to /usr/sbin
		dosbin sgauth
		# Install file into specified directory
		insinto /etc/stargazer
		doins sgauth.conf
		# Correct permissions for file
		fperms 0640 /etc/stargazer/sgauth.conf
	fi
	
	if use sgconf; then
		# Change current directory
		cd ${S}/projects/sgconf
		# Call make install
		emake DESTDIR="${D}" PREFIX="${D}" install
		# Install sgconf binnary file to /usr/sbin
		dobin sgconf
	fi
	
	if use xmlrpc; then
		# Change current directory
		cd ${S}/projects/sgconf_xml
		# Call make install
		emake DESTDIR="${D}" PREFIX="${D}" install
		# Install sgconf_xml binnary file to /usr/bin
		dobin sgconf_xml
	fi
	
	if use stargazer; then
		# Change current directory
		cd ${S}/projects/stargazer
		# Call make install
		emake DESTDIR="${D}" PREFIX="${D}" install
		# Remove static libs if USE flag is not selected
		use static-libs || find "${D}" -name '*.a' -exec rm -f {} +
		# Install docs
		dodoc BUGS CHANGES README TODO
		# Install and rename Gentoo init script
		newinitd ${S}/projects/stargazer/inst/linux/etc/init.d/stargazer.gentoo stargazer
		# Install stargazer binnary file to /usr/sbin
		dosbin stargazer
		# Create necessary directories
		diropts -m 755 -o stg -g stg
		dodir /var/log/stargazer
		# Install files needed for module_store_files
		if use module_store_files; then
			# Install files into specified directory
			insinto /var/lib
			doins -r ${S}/projects/stargazer/inst/var/stargazer
			# Correct user and group for files and directories
			fowners -R stg:stg /var/lib/stargazer
		fi
		if use module_other_smux; then
			# Install files into specified directory
			insinto /usr/share/snmp/mibs
			doins ${S}/projects/stargazer/plugins/other/smux/STG-MIB.mib
		fi
		if use module_other_remote_script; then
			# Create subnets file based on example from mod_remote_script.conf
			grep 192 ${S}/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/mod_remote_script.conf | sed 's/# //' > ${D}/etc/stargazer/subnets
			# Correct permissions for file
			fperms 0640 /etc/stargazer/subnets
		fi
		# Install files into specified directory
		insinto /etc/stargazer
		doins \
			${S}/projects/stargazer/inst/linux/etc/stargazer/OnChange \
			${S}/projects/stargazer/inst/linux/etc/stargazer/OnConnect \
			${S}/projects/stargazer/inst/linux/etc/stargazer/OnDisconnect \
			${S}/projects/stargazer/inst/linux/etc/stargazer/OnUserAdd \
			${S}/projects/stargazer/inst/linux/etc/stargazer/OnUserDel \
			${S}/projects/stargazer/inst/linux/etc/stargazer/rules \
			${S}/projects/stargazer/inst/linux/etc/stargazer/stargazer.conf
		# Correct permissions for files
		fperms 0755 \
			/etc/stargazer/OnChange \
			/etc/stargazer/OnConnect \
			/etc/stargazer/OnDisconnect \
			/etc/stargazer/OnUserAdd \
			/etc/stargazer/OnUserDel
		# Correct permissions for files
		fperms 0640 \
			/etc/stargazer/rules \
			/etc/stargazer/stargazer.conf
		# Install files into specified directory for selected modules
		insinto /etc/stargazer/conf-available.d
		insopts -m 0640
		use module_auth_always_online	&& doins ${S}/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/mod_ao.conf
		use module_auth_internet_access	&& doins ${S}/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/mod_ia.conf
		use module_auth_freeradius	&& doins ${S}/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/mod_radius.conf
		use module_capture_ipq		&& doins ${S}/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/mod_cap_ipq.conf
		use module_capture_netflow	&& doins ${S}/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/mod_cap_nf.conf
		use module_config_sgconfig	&& doins ${S}/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/mod_sg.conf
		use module_config_rpcconfig	&& doins ${S}/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/mod_rpc.conf
		use module_other_ping		&& doins ${S}/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/mod_ping.conf
		use module_other_smux		&& doins ${S}/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/mod_smux.conf
		use module_other_remote_script	&& doins ${S}/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/mod_remote_script.conf
		use module_store_files		&& doins ${S}/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/store_files.conf
		use module_store_firebird	&& doins ${S}/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/store_firebird.conf
		use module_store_mysql		&& doins ${S}/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/store_mysql.conf
		use module_store_postgres	&& doins ${S}/projects/stargazer/inst/linux/etc/stargazer/conf-available.d/store_postgresql.conf
		# Create symlinks of configs for selected modules
		use module_auth_always_online	&& dosym /etc/stargazer/conf-available.d/mod_ao.conf		/etc/stargazer/conf-enabled.d/mod_ao.conf
		use module_auth_internet_access	&& dosym /etc/stargazer/conf-available.d/mod_ia.conf		/etc/stargazer/conf-enabled.d/mod_ia.conf
		use module_auth_freeradius	&& dosym /etc/stargazer/conf-available.d/mod_radius.conf	/etc/stargazer/conf-enabled.d/mod_radius.conf
		use module_capture_ipq		&& dosym /etc/stargazer/conf-available.d/mod_cap_ipq.conf	/etc/stargazer/conf-enabled.d/mod_cap_ipq.conf
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
	( use convertor || use rscriptd || use sgauth || use stargazer ) && fowners -R stg:stg /etc/stargazer
}