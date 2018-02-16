# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN=${PN%%-bin}
MY_P="${MY_PN}_${PV}"

inherit eutils systemd unpacker user

DESCRIPTION="Scalable datastore for metrics, events, and real-time analytics"
HOMEPAGE="http://influxdata.com"
SRC_URI="https://dl.influxdata.com/influxdb/releases/${MY_P}_amd64.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="logrotate"

RDEPEND="logrotate? ( app-admin/logrotate )"

S="${WORKDIR}"

pkg_setup() {
	enewgroup "${MY_PN}"
	enewuser "${MY_PN}" -1 -1 /var/lib/"${MY_PN}" "${MY_PN}"
}

src_install() {
	# Install configuration files
	insinto /etc/"${MY_PN}"
	doins etc/"${MY_PN}"/"${MY_PN}".conf
	use logrotate && doins etc/logrotate.d/"${MY_PN}"

	# Install binary files
	dobin	usr/bin/influx \
		usr/bin/influxd \
		usr/bin/influx_inspect \
		usr/bin/influx_stress \
		usr/bin/influx_tsm

	# Create log directory
	keepdir /var/log/"${MY_PN}"
	fowners -R "${MY_PN}":"${MY_PN}" /var/log/"${MY_PN}"

	systemd_dounit usr/lib/"${MY_PN}"/scripts/"${MY_PN}".service
	newinitd "${FILESDIR}"/"${MY_PN}".initd "${MY_PN}"
	newconfd "${FILESDIR}"/"${MY_PN}".confd "${MY_PN}"
}
