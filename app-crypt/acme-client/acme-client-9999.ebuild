# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/graywolf/acme-client-portable.git"

inherit autotools git-r3 systemd

DESCRIPTION="Secure Let's Encrypt client"
HOMEPAGE="https://github.com/graywolf/acme-client-portable"
SRC_URI=""

LICENSE="ISC MIT"
SLOT="0"
KEYWORDS=""
IUSE="libressl"

RDEPEND="!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default

	eautoreconf
}

src_install() {
	default

	keepdir /var/lib/acme-client/{accounts,certs}
	insinto /etc/acme-client.d
	doins "${FILESDIR}"/example.org.hook
	insinto /etc
	doins "${FILESDIR}"/acme-client.conf

	systemd_dounit "${FILESDIR}"/acme-client.{service,timer}
}
