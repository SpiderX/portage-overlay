# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="An ACME Shell script"
HOMEPAGE="https://github.com/acmesh-official/acme.sh"
SRC_URI="https://github.com/acmesh-official/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="dev-libs/openssl:0
	net-misc/curl
	net-misc/socat"

S="${WORKDIR}/${MY_P}"

src_install() {
	einstalldocs
	newdoc dnsapi/README.md README-dnsapi.md
	newdoc deploy/README.md README-deploy.md
	rm {deploy,dnsapi}/README.md || die "rm failed"

	keepdir /etc/acme-sh
	doenvd "${FILESDIR}"/99acme-sh
	insinto /etc/bash/bashrc.d
	doins "${FILESDIR}"/acme.sh

	exeinto /usr/share/acme.sh
	doexe acme.sh

	insinto /usr/share/acme.sh
	doins -r deploy dnsapi notify

	dosym ../share/acme.sh/acme.sh usr/bin/acme.sh
}

pkg_postinst() {
	optfeature_header "For webserver mode, install a supported web server:"
	optfeature "using apache2 webserver mode" www-servers/apache
	optfeature "using nginx webserver mode" www-servers/nginx
}
