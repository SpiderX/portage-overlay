# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="NTRIP Relay"
HOMEPAGE="https://github.com/madf/ntriprelay"
SRC_URI="https://github.com/madf/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/boost:0=
	dev-libs/openssl:0="

src_install() {
	einstalldocs
	dobin "${S}"_build/src/ntriprelay

	newinitd "${FILESDIR}"/ntriprelay.initd ntriprelay
	newconfd "${FILESDIR}"/ntriprelay.confd ntriprelay
}
