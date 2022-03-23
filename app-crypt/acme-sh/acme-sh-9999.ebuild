# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/acmesh-official/${PN/-/.}.git"

inherit git-r3 optfeature

DESCRIPTION="An ACME Shell script"
HOMEPAGE="https://github.com/acmesh-official/acme.sh"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-libs/openssl:0
	net-misc/curl
	net-misc/socat"

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
