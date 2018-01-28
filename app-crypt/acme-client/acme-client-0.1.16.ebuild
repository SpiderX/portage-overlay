# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit systemd toolchain-funcs

MY_PN="${PN}-portable"
MY_PV="VERSION_${PV//./_}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Secure Let's Encrypt client"
HOMEPAGE="https://kristaps.bsd.lv/${PN}/"
SRC_URI="https://github.com/kristapsdz/${MY_PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="seccomp systemd"

RDEPEND="dev-libs/libbsd
	dev-libs/libressl
	sys-libs/libseccomp"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}"/${P}-FLAGS.patch
	"${FILESDIR}"/${P}-agreement-url.patch )


S="${WORKDIR}/${MY_P}"

src_prepare() {
	default

	use seccomp || eapply "${FILESDIR}"/${P}-seccomp.patch
}

src_compile() {
	emake CC=$(tc-getCC)
}

src_install() {
	einstalldocs
	emake DESTDIR="${D}" PREFIX=/usr/ install

	keepdir /var/lib/acme-client/{accounts,certs}
	insinto /etc/acme-client
	doins "${FILESDIR}"/example.conf

	#use systemd || newinitd "${FILESDIR}"/${PN}.initd ${PN}
	#use systemd || newconfd "${FILESDIR}"/${PN}.confd ${PN}
	use systemd && systemd_dounit "${FILESDIR}"/${PN}.{service,timer}
}
