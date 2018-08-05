# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="An ACME Shell script"
HOMEPAGE="https://github.com/Neilpang/acme.sh"
SRC_URI="https://github.com/Neilpang/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="apache2 +cron nginx libressl standalone"

RDEPEND="net-misc/curl
	|| ( net-analyzer/netcat6 net-analyzer/openbsd-netcat )
	sys-apps/iproute2
	sys-apps/net-tools
	sys-apps/util-linux
	apache2? ( www-servers/apache:2 )
	cron? ( virtual/cron )
	libressl? ( dev-libs/libressl )
	!libressl? ( dev-libs/openssl:0= )
	nginx? ( www-servers/nginx:0 )
	standalone? ( net-misc/socat )"

S="${WORKDIR}/${MY_P}"

src_install() {
	einstalldocs
	newdoc dnsapi/README.md README-dnsapi.md
	newdoc deploy/README.md README-deploy.md

	keepdir /etc/acme-sh
	doenvd "${FILESDIR}"/99acme-sh
	insinto /etc/bash/bashrc.d
	doins "${FILESDIR}"/acme.sh

	insinto /usr/share/acme.sh
	doins acme.sh
	insinto /usr/share/acme.sh/dnsapi
	doins -r dnsapi/*.sh
	insinto /usr/share/acme.sh/deploy
	doins -r deploy/*.sh

	dosym ../share/acme.sh/acme.sh usr/bin/acme.sh
	fperms +x /usr/bin/acme.sh
}
