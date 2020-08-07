# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools systemd

DESCRIPTION="A dynamic swap space manager"
HOMEPAGE="https://github.com/Tookmund/Swapspace"
SRC_URI="https://github.com/Tookmund/${PN^}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="acct-user/swapspace"

S="${WORKDIR}/${P^}"

src_prepare() {
	default

	# Change paths
	sed -i '/ExecStart/s|local/||' swapspace.service \
		|| die "sed failed for swapspace.service"
	sed  -i '/swappath/s|#||;s|/usr/local||' swapspace.conf \
		|| die "sed failed for swapspace.conf"

	eautoreconf
}

src_configure() {
	econf --localstatedir=/var --sysconfdir=/etc/swapspace
}

src_install() {
	default

	keepdir /var/lib/swapspace
	systemd_dounit swapspace.service
	newinitd "${FILESDIR}"/swapspace.initd swapspace
	newconfd "${FILESDIR}"/swapspace.confd swapspace
}
