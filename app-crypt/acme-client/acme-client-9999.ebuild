# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3 systemd

DESCRIPTION="Secure Let's Encrypt client"
HOMEPAGE="https://git.sr.ht/~graywolf/acme-client-portable"
EGIT_REPO_URI="https://git.sr.ht/~graywolf/acme-client-portable"

LICENSE="GPL-2"
SLOT="0"

RDEPEND="dev-libs/openssl:0="
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
