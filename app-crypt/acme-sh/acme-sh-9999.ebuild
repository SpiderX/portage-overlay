# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"
EGIT_REPO_URI="https://github.com/Neilpang/${MY_PN}.git"

inherit git-r3

DESCRIPTION="An ACME Shell script"
HOMEPAGE="https://github.com/Neilpang/acme.sh"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

src_install() {
	einstalldocs
	newdoc dnsapi/README.md README-dnsapi.md
	newdoc deploy/README.md README-deploy.md

	insinto /usr/share/acme.sh
	doins acme.sh
	insinto /usr/share/acme.sh/dnsapi
	doins -r dnsapi/*.sh
	insinto /usr/share/acme.sh/deploy
	doins -r deploy/*.sh

	dosym ../share/acme.sh/acme.sh usr/bin/acme.sh
	fperms +x /usr/bin/acme.sh
}
