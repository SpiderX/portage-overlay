# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit pax-utils rpm

MY_PN="mapforceserveradv"
MY_PV="${PV/_p/rel}"

DESCRIPTION="Advanced data mapping, conversion, and transformation tool"
HOMEPAGE="https://www.altova.com/mapforce"
SRC_URI="https://cdn.sw.altova.com/v${MY_PV/rel/r}sp1/multi-lingual/${MY_PN}-${MY_PV}sp1-1.x86_64.rpm"

LICENSE="Altova"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror strip"

RDEPEND="acct-user/mapforce
	dev-libs/openssl:0=
	virtual/krb5"

S="${WORKDIR}"

src_install() {
	cp -a opt/. "${ED}"/opt/ || die "cp failed"

	pax-mark m "${ED}"/opt/Altova/MapForceServer2020/bin/mapforceserver{,_de,_es,_fr,_ja}
}
