# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/madf/${PN}.git"

inherit cmake git-r3

DESCRIPTION="NTRIP Relay"
HOMEPAGE="https://github.com/madf/ntriprelay"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-libs/boost:0=
	dev-libs/openssl:0="

src_install() {
	einstalldocs
	dobin "${S}"_build/src/ntriprelay

	newinitd "${FILESDIR}"/ntriprelay.initd ntriprelay
	newconfd "${FILESDIR}"/ntriprelay.confd ntriprelay
}
