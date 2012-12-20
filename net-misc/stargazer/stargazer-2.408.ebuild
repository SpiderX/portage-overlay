# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/putty/putty-0.61.ebuild,v 1.4 2011/09/04 13:51:35 maekke Exp $

EAPI="4"

inherit eutils

DESCRIPTION="Stargtazer billing system for small home and office networks"
HOMEPAGE="http://stg.dp.ua/"
MY_P="stg-${PV}"
SRC_URI="http://stg.dp.ua/download/server/${PV}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="convertor radius rscriptd sgauth sgconf xmlrpc stargazer debug doc examples"
MERGE_TYPE="source"

PROJECTS="convertor rlm_stg rscriptd sgauth sgconf sgconf_xml stargazer"
MODULES_AUTH="always_online internet_access freeradius"
MODULES_CAP="ipq ether netflow"
MODULES_CONFIG="sgconfig rpcconfig"
MODULES_OTHER="ping smux remote_script"
MODULES_STORE="files firebird mysql postgres"

for module in ${MODULES_AUTH}; do
        IUSE="${IUSE} module_auth_${module}"
done

for module in ${MODULES_CAP}; do
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

REQUIRED_USE="convertor? ( module_store_files || ( module_store_firebird module_store_mysql module_store_postgres ) )"
REQUIRED_USE="stargazer? ( || ( module_store_files module_store_firebird module_store_mysql module_store_postgres ) )"

RDEPEND="
	dev-libs/expat[expat(+)]
	xmlrpc? ( dev-libs/xmlrpc-c )
	module_auth_freeradius? ( net-dialup/freeradius )
	module_store_firebird? ( dev-db/firebird )
	module_store_mysql? ( dev-db/mysql )
	module_store_postgres? ( dev-libs/libpqxx
				sys-libs/zlib )
"

DEPEND="
	${RDEPEND}
"

src_prepare() {
	# Rename build script to configure for further econf launch in all projects
	for project in ${PROJECTS}; do
		mv ${S}/projects/${project}/build ${S}/projects/${project}/configure
	done
	
	# Correct working directory, user and group
	epatch "${FILESDIR}"/convertor.conf.patch
	# Correct path for files and directories
	epatch "${FILESDIR}"/rscriptd.conf.patch
	
	# Remove target install-data (if more - cycle)
	sed -i 's/install: install-bin install-data/install: install-bin/' ${S}/projects/stargazer/Makefile
	sed -i 's/install: install-bin install-data/install: install-bin/' ${S}/projects/rscriptd/Makefile
	sed -i 's/install: install-bin install-data/install: install-bin/' ${S}/projects/sgauth/Makefile
	sed -i 's/install: install-bin install-data/install: install-bin/' ${S}/projects/sgconf_xml/Makefile
	# Remove stargazer binary file install
	sed -i 's/install -m $(BIN_MODE) -o $(OWNER) -s $(PROG) $(PREFIX)\/usr\/sbin\/$(PROG)//' ${S}/projects/stargazer/Makefile
	# Remove rlm_stg.so binary file install
	sed -i 's/install -m $(BIN_MODE) -o $(OWNER) -s $(PROG) $(PREFIX)\/usr\/lib\/$(PROG)//' ${S}/projects/rlm_stg/Makefile
	# Remove rscriptd binary file install
	sed -i 's/install -m $(BIN_MODE) -o $(OWNER) -s $(PROG) $(PREFIX)\/usr\/sbin\/$(PROG)//' ${S}/projects/rscriptd/Makefile
	# Remove sgauth binary file install
	sed -i 's/install -m $(BIN_MODE) -o $(OWNER) -s $(PROG) $(PREFIX)\/usr\/sbin\/$(PROG)//' ${S}/projects/sgauth/Makefile
	# Remove sgconf binary file install
	sed -i 's/install -m $(BIN_MODE) -o $(OWNER) -s $(PROG) $(PREFIX)\/usr\/sbin\/$(PROG)//' ${S}/projects/sgconf/Makefile
	# Remove sgconf_xml binary file install
	sed -i 's/install -m $(BIN_MODE) -o $(OWNER) -s $(PROG) $(PREFIX)\/usr\/sbin\/$(PROG)//' ${S}/projects/sgconf_xml/Makefile
	
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
}

src_configure() {
	# Define local variables
	local USEFLAGS=($IUSE)
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
	# Add stg user to system
	enewgroup stg
	# Add stg group to system
	enewuser stg -1 -1 /var/lib/stargazer stg
}

#pkg_postinst() {
#}

src_install() {
	# Install changelog
	dodoc ChangeLog
	# Create necessary directories
	dodir \
		/etc/stargazer \
		/usr/share/stargazer/db \
		/usr/share/stargazer/db/mysql \
		/usr/share/stargazer/db/postgresql
	# ?????
	keepdir \
		/etc/stargazer \
		/var/lib/stargazer \
		/var/lib/stargazer/admins \
		/var/lib/stargazer/tariffs \
		/var/lib/stargazer/users
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
		insinto /usr/share/stargazer/scripts
		doins -r ${S}/projects/stargazer/scripts/*
	fi
	
	if use convertor; then
		# Install convertor binnary file to /usr/bin
		dobin ${S}/projects/convertor/convertor
		# Install files into specified directory
		insinto /etc/stargazer
		doins ${S}/projects/convertor/convertor.conf
		# Correct user and group for file
		fowners stg:stg /etc/stargazer/convertor.conf
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
		# Correct user and group for file
		fowners stg:stg /etc/stargazer/rscriptd.conf
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
		# Correct user and group for file
		fowners stg:stg /etc/stargazer/sgauth.conf
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
		# Install docs
		dodoc BUGS CHANGES README TODO
		# Install and rename Gentoo init script
		newinitd ${S}/projects/stargazer/inst/linux/etc/init.d/stargazer.gentoo stargazer
		# Install stargazer binnary file to /usr/sbin
		dosbin stargazer
		# Create necessary directories
		dodir \
			/etc/stargazer/conf-available.d \
			/etc/stargazer/conf-enabled.d \
			/var/lib/stargazer/admins \
			/var/lib/stargazer/tariffs \
			/var/lib/stargazer/users \
			/var/lib/stargazer/users/test \
			/var/log/stargazer \
			/var/run/stargazer
		# Install files needed for module_store_files
		if use module_store_files; then
			# Install files into specified directory
			insinto /var/lib/stargazer/admins
			doins ${S}/projects/stargazer/inst/var/stargazer/admins/admin.adm
			# Correct user and group for file
			fowners stg:stg /var/lib/stargazer/admins/admin.adm
			# Correct permissions for file
			fperms 0640 /var/lib/stargazer/admins/admin.adm
			# Install files into specified directory
			insinto /var/lib/stargazer/tariffs
			doins ${S}/projects/stargazer/inst/var/stargazer/tariffs/tariff.tf
			# Correct user and group for file
			fowners stg:stg /var/lib/stargazer/tariffs/tariff.tf
			# Correct permissions for file
			fperms 0640 /var/lib/stargazer/tariffs/tariff.tf
			# Install files into specified directory
			insinto /var/lib/stargazer/users/test
			doins ${S}/projects/stargazer/inst/var/stargazer/users/test/*
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
		# Correct user and group for files
		fowners -R stg:stg /var/lib/stargazer
		# Correct permissions for files
		fperms -R 0640 /var/lib/stargazer/users/test/
		# Correct user and group for files
		fowners -R stg:stg /etc/stargazer
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
	fi
	
	insinto /etc/stargazer/conf-available.d
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
	fowners	-R stg:stg /etc/stargazer/conf-available.d/
	fperms	-R 0640 /etc/stargazer/conf-available.d/
	
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
}
