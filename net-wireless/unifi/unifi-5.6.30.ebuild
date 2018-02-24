# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="UniFi"

inherit eutils systemd user

DESCRIPTION="Management Controller for Ubiquiti Networks UniFi APs"
HOMEPAGE="http://www.ubnt.com/unifi https://community.ubnt.com/unifi"
SRC_URI="http://dl.ubnt.com/unifi/${PV}/${MY_PN}.unix.zip -> ${P}.zip"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-db/mongodb
	virtual/jre:1.8"

S="${WORKDIR}/${MY_PN}"

RESTRICT="bindist mirror preserve-libs strip"

DOCS=( readme.txt )

pkg_setup() {
	enewgroup "${PN}"
	enewuser "${PN}" -1 /bin/sh /var/lib/"${PN}" "${PN}"
}

src_prepare() {
	default

	rm -r {lib/native/Linux/armhf,lib/native/Windows,lib/native/Mac} \
		|| die "remove armhf,Windows,Mac lib failed"
}

src_install() {
	default

	dodir /usr/"$(get_libdir)"/"${PN}"

	cp -R "${S}"/{bin,conf,dl,lib,webapps} "${ED%/}"/usr/"$(get_libdir)"/"${PN}"

	keepdir /var/lib/"${PN}"/data
	dodir \
		/var/lib/"${PN}"/work \
		/var/lib/"${PN}"/run \
		/var/log/"${PN}"

	fowners -R "${PN}":"${PN}" /var/lib/"${PN}" /var/log/"${PN}"

	dosym ../../../var/lib/"${PN}"/data /usr/"$(get_libdir)"/"${PN}"/data
	dosym ../../../var/lib/"${PN}"/work /usr/"$(get_libdir)"/"${PN}"/work
	dosym ../../../var/lib/"${PN}"/run /usr/"$(get_libdir)"/"${PN}"/run
	dosym ../../../var/log/"${PN}" /usr/"$(get_libdir)"/"${PN}"/logs

	echo 'CONFIG_PROTECT="/var/lib/unifi/data/system.properties"' > 99"${PN}"
	doenvd 99"${PN}"

	newconfd "${FILESDIR}"/"${PN}".confd "${PN}"
	newinitd "${FILESDIR}"/"${PN}".initd "${PN}"
	systemd_dounit "${FILESDIR}"/"${PN}".service
}
