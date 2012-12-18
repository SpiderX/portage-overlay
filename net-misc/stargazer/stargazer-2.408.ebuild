# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/putty/putty-0.61.ebuild,v 1.4 2011/09/04 13:51:35 maekke Exp $

EAPI="4"

#inherit autotools toolchain-funcs eutils
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
	dev-libs/expat[expat(+)]"
#	xmlrpc? ( dev-libs/xmlrpc-c )
#	module_auth_freeradius? ( net-dialup/freeradius )
#	module_store_firebird? ( dev-db/firebird )
#	module_store_mysql? ( dev-db/mysql )
#	module_store_postgres? ( dev-libs/libpqxx
#				sys-libs/zlib )

DEPEND="
	${RDEPEND}
"

src_prepare() {
	for project in ${PROJECTS}; do
		mv ${S}/projects/${project}/build ${S}/projects/${project}/configure
	done
	
	# test patch !!!!PATCH FOR CONVERTOR FOR ALL POSIBILITIES
	#epatch "${FILESDIR}"/configure.patch
	
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
	
	if use stargazer; then
		sed -i 's/opts/extra_commands/' ${S}/projects/stargazer/inst/linux/etc/init.d/stargazer.gentoo
		#remove after test newinitdmv ${S}/projects/stargazer/inst/linux/etc/init.d/stargazer.gentoo ${S}/projects/stargazer/inst/linux/etc/init.d/stargazer
	fi
}

src_configure() {
	local USEFLAGS=($IUSE)
	local PROJECTS=($PROJECTS)
	
	for (( i = 0 ; i < ${#PROJECTS[@]} ; i++ )); do
		if use ${USEFLAGS[$i]} ; then
			cd ${S}/projects/${PROJECTS[$i]} || die "cd to ${PROJECTS[$i]} failed"
			econf
		fi
	done
}
#kg_{setup,preinst,postinst}
pkg_setup() {
	enewgroup stg
	enewuser stg -1 -1 /var/lib/stargazer stg
}

src_install() {
	#emake DESTDIR="${D}" install
	dodoc ChangeLog 
	#doinit /projects/stargazer/inst/linux/etc/init.d
	#if use doc; then
	#	dodoc doc/puttydoc.txt
	#	dohtml doc/*.html
	#fi
	
	dodir \
		/etc/stargazer \
		/usr/share/stargazer/db \
		/usr/share/stargazer/db/mysql \
		/usr/share/stargazer/db/postgresql
	insinto /usr/share/stargazer/db
	doins \
		${S}/projects/stargazer/inst/var/00-base-00.sql \
		${S}/projects/stargazer/inst/var/00-alter-01.sql
	insinto /usr/share/stargazer/db/mysql
	doins ${S}/projects/stargazer/inst/var/00-mysql-01.sql
	insinto /usr/share/stargazer/db/postgresql
	doins \
		${S}/projects/stargazer/inst/var/00-base-00.postgresql.sql \
		${S}/projects/stargazer/inst/var/00-alter-01.postgresql.sql
	
	if use doc; then
		insinto /usr/share/stargazer/db
		doins ${S}/projects/stargazer/inst/var/base.dia
	fi
	
	if use examples; then
		dodir \
			/usr/share/stargazer/scripts \
			/usr/share/stargazer/scripts/shaper \
			/usr/share/stargazer/scripts/shaper_vpn_radius
		insinto /usr/share/stargazer/scripts
		doins \
			${S}/projects/stargazer/scripts/clean_db \
			${S}/projects/stargazer/scripts/monitor
		insinto /usr/share/stargazer/scripts/shaper
		doins ${S}/projects/stargazer/scripts/shaper/*
		insinto /usr/share/stargazer/scripts/shaper_vpn_radius
		doins ${S}/projects/stargazer/scripts/shaper_vpn_radius/*
	fi
	
	if use convertor; then
		insinto /etc/stargazer
		doins ${S}/projects/convertor/convertor.conf
		dobin ${S}/projects/convertor/convertor
		fowners stg:stg /etc/stargazer/convertor.conf
		fperms 0640 /etc/stargazer/convertor.conf
	fi
	
	if use radius; then
		insinto /usr/lib/freeradius
		doins ${S}/projects/rlm_stg/rlm_stg.so
	fi
	
	if use rscriptd; then
		insinto /etc/stargazer
		doins ${S}/projects/rscriptd/rscriptd.conf
		dosbin ${S}/projects/rscriptd/rscriptd
	fi
	
	#css??
	if use sgauth; then
		insinto /etc/stargazer
		doins ${S}/projects/sgauth/sgauth.conf
		dobin ${S}/projects/sgauth/sgauth
	fi
	
	if use sgconf; then
		dobin ${S}/projects/sgconf/sgconf
	fi
	
	if use xmlrpc; then
		dobin ${S}/projects/sgconf_xml/sgconf_xml
	fi
	
	if use stargazer; then
		dodoc ${S}/projects/stargazer/BUGS ${S}/projects/stargazer/CHANGES ${S}/projects/stargazer/README ${S}/projects/stargazer/TODO
		newinitd ${S}/projects/stargazer/inst/linux/etc/init.d/stargazer.gentoo stargazer
		dodir \
			/etc/stargazer/conf-available.d \
			/etc/stargazer/conf-enabled.d \
			/var/lib/stargazer \
			/var/lib/stargazer/admins \
			/var/lib/stargazer/tariffs \
			/var/lib/stargazer/users \
			/var/lib/stargazer/users/test \
			/var/log/stargazer \
			/var/run/stargazer
		insinto /var/lib/stargazer/admins
		doins ${S}/projects/stargazer/inst/var/stargazer/admins/admin.adm
		fowners stg:stg /var/lib/stargazer/admins/admin.adm
		fperms 0640 /var/lib/stargazer/admins/admin.adm
		insinto /var/lib/stargazer/tariffs
		doins ${S}/projects/stargazer/inst/var/stargazer/tariffs/tariff.tf
		fowners stg:stg /var/lib/stargazer/tariffs/tariff.tf
		fperms 0640 /var/lib/stargazer/tariffs/tariff.tf
		insinto /var/lib/stargazer/users/test
		doins \
			${S}/projects/stargazer/inst/var/stargazer/users/test/conf \
			${S}/projects/stargazer/inst/var/stargazer/users/test/stat
		insinto /etc/stargazer
		doins \
			${S}/projects/stargazer/inst/linux/etc/stargazer/OnChange \
			${S}/projects/stargazer/inst/linux/etc/stargazer/OnConnect \
			${S}/projects/stargazer/inst/linux/etc/stargazer/OnDisconnect \
			${S}/projects/stargazer/inst/linux/etc/stargazer/OnUserAdd \
			${S}/projects/stargazer/inst/linux/etc/stargazer/OnUserDel \
			${S}/projects/stargazer/inst/linux/etc/stargazer/rules \
			${S}/projects/stargazer/inst/linux/etc/stargazer/stargazer.conf
		fowners -R stg:stg /var/lib/stargazer
		fperms -R 0640 /var/lib/stargazer/users/test/
		fowners -R stg:stg /etc/stargazer
		fperms 0755 \
			/etc/stargazer/OnChange \
			/etc/stargazer/OnConnect \
			/etc/stargazer/OnDisconnect \
			/etc/stargazer/OnUserAdd \
			/etc/stargazer/OnUserDel
		fperms 0640 \
			/etc/stargazer/rules \
			/etc/stargazer/stargazer.conf
	fi
	
	# do fowners and fperms in cycle for all modules, doins rewrite with [] &&
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
	fowners -R stg:stg /etc/stargazer/conf-available.d/
	fperms -R 0640 /etc/stargazer/conf-available.d/
	#insinto /etc/stargazer/conf-enabled.d
	use module_auth_always_online	&& dosym /etc/stargazer/conf-available.d/mod_ao.conf /etc/stargazer/conf-enabled.d/mod_ao.conf
	use module_auth_internet_access	&& dosym /etc/stargazer/conf-available.d/mod_ia.conf /etc/stargazer/conf-enabled.d/mod_ia.conf
	use module_auth_freeradius	&& dosym /etc/stargazer/conf-available.d/mod_radius.conf /etc/stargazer/conf-enabled.d/mod_radius.conf
	use module_capture_ipq		&& dosym /etc/stargazer/conf-available.d/mod_cap_ipq.conf /etc/stargazer/conf-enabled.d/mod_cap_ipq.conf
	use module_capture_netflow	&& dosym /etc/stargazer/conf-available.d/mod_cap_nf.conf /etc/stargazer/conf-enabled.d/mod_cap_nf.conf
	use module_config_sgconfig	&& dosym /etc/stargazer/conf-available.d/mod_sg.conf /etc/stargazer/conf-enabled.d/mod_sg.conf
	use module_config_rpcconfig	&& dosym /etc/stargazer/conf-available.d/mod_rpc.conf /etc/stargazer/conf-enabled.d/mod_rpc.conf
	use module_other_ping		&& dosym /etc/stargazer/conf-available.d/mod_ping.conf /etc/stargazer/conf-enabled.d/mod_ping.conf
	use module_other_smux		&& dosym /etc/stargazer/conf-available.d/mod_smux.conf /etc/stargazer/conf-enabled.d/mod_smux.conf
	use module_other_remote_script	&& dosym /etc/stargazer/conf-available.d/mod_remote_script.conf /etc/stargazer/conf-enabled.d/mod_remote_script.conf
	use module_store_files		&& dosym /etc/stargazer/conf-available.d/store_files.conf /etc/stargazer/conf-enabled.d/store_files.conf
	use module_store_firebird	&& dosym /etc/stargazer/conf-available.d/store_firebird.conf /etc/stargazer/conf-enabled.d/store_firebird.conf
	use module_store_mysql		&& dosym /etc/stargazer/conf-available.d/store_mysql.conf /etc/stargazer/conf-enabled.d/store_mysql.conf
	use module_store_postgres	&& dosym /etc/stargazer/conf-available.d/store_postgresql.conf /etc/stargazer/conf-enabled.d/store_postgresql.conf
}
