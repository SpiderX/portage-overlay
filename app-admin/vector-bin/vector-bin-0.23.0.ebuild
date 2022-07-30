# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit pax-utils systemd unpacker

QA_PREBUILT="usr/bin/vector"
MY_PN="${PN/-bin/}"

DESCRIPTION="High performance logs, metrics, and events router"
HOMEPAGE="https://github.com/vectordotdev/vector"
SRC_URI="https://github.com/vectordotdev/${MY_PN}/releases/download/v${PV}/${MY_PN}_${PV}-1_amd64.deb"

LICENSE="MPL-2.0"
KEYWORDS="~amd64"
SLOT="0"
RESTRICT="bindist mirror"

RDEPEND="acct-user/vector"

S="${WORKDIR}"

src_install() {
	dobin usr/bin/vector
	pax-mark m "${ED}"/usr/bin/vector

	insopts -o vector -g vector -m 0644
	insinto /etc/vector
	doins etc/vector/vector.toml

	insinto /usr/share/vector/examples
	doins -r etc/vector/examples/.

	newinitd "${FILESDIR}"/vector.initd vector
	newconfd "${FILESDIR}"/vector.confd vector
	systemd_dounit lib/systemd/system/vector.service
}
