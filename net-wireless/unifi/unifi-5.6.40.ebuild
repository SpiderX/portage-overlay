# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="UniFi"

inherit eutils systemd user

DESCRIPTION="Management Controller for Ubiquiti Networks UniFi APs"
HOMEPAGE="https://unifi-sdn.ubnt.com/ https://community.ubnt.com/unifi"
SRC_URI="http://dl.ubnt.com/unifi/${PV}/${MY_PN}.unix.zip -> ${P}.zip"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-db/mongodb
	virtual/jre:1.8"

S="${WORKDIR}/${MY_PN}"

RESTRICT="bindist mirror preserve-libs strip"

pkg_setup() {
	enewgroup unifi
	enewuser unifi -1 /bin/sh /var/lib/unifi unifi
}

src_prepare() {
	default

	rm -r {lib/native/Linux/armhf,lib/native/Windows,lib/native/Mac} \
		|| die "remove armhf,Windows,Mac lib failed"
}

src_install() {
	default

	dodir /usr/"$(get_libdir)"/unifi

	#cp -R "${S}"/{bin,conf,dl,lib,webapps} "${ED%/}"/usr/"$(get_libdir)"/unifi
	cp -R {bin,conf,dl,lib,webapps} "${ED%/}"/usr/"$(get_libdir)"/unifi

	echo 'CONFIG_PROTECT="/var/lib/unifi/data/system.properties"' > 99unifi
	doenvd 99unifi

	newconfd "${FILESDIR}"/unifi.confd unifi
	newinitd "${FILESDIR}"/unifi.initd unifi
	systemd_dounit "${FILESDIR}"/unifi.service

	diropts -o unifi -g unifi
	keepdir /var/lib/unifi/data
	dodir /var/lib/unifi/work /var/lib/unifi/run /var/log/unifi

	dosym ../../../var/lib/unifi/data /usr/"$(get_libdir)"/unifi/data
	dosym ../../../var/lib/unifi/work /usr/"$(get_libdir)"/unifi/work
	dosym ../../../var/lib/unifi/run /usr/"$(get_libdir)"/unifi/run
	dosym ../../../var/log/unifi /usr/"$(get_libdir)"/unifi/logs
}
