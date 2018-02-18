# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools readme.gentoo-r1 user

DESCRIPTION="RSS downloader for Tranmission"
HOMEPAGE="https://github.com/1100101/Automatic"
SRC_URI="https://github.com/1100101/Automatic/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/libxml2:2
	dev-libs/libpcre:3
	net-misc/curl"
DEPEND="${RDEPEND}
	app-admin/logrotate"

S="${WORKDIR}/${P^}"

DOC_CONTENTS="To run automatic you should move /etc/automatic.conf-sample
to /etc/automatic.conf and config it.\\n
If things go wrong, increase verbose level in /etc/conf.d/automatic
and check log file in /var/log/automatic/\\n"

src_prepare() {
	default

	# https://bugs.gentoo.org/426262
	mv configure.{in,ac} || die "rename failed"

	# Remove CFLAGS and CXXFLAGS defined by upstream
	sed -i \
		-e 's/CFLAGS="-Wdeclaration-after-statement -O3 -funroll-loops"/CFLAGS+=""/' \
		-e 's/CXXFLAGS="-O3 -funroll-loops"/CXXFLAGS+=""/' \
		configure.ac || die "sed for CXXFLAGS and CFLAGS failed"

	eautoreconf
}

src_install() {
	default

	newinitd "${FILESDIR}"/"${PN}".initd "${PN}"
	newconfd "${FILESDIR}"/"${PN}".confd "${PN}"
	keepdir /var/lib/"${PN}"/
	keepdir /var/log/"${PN}"/

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/"${PN}".logrotate "${PN}"

	readme.gentoo_create_doc
}

pkg_postinst() {
	enewgroup "${PN}"
	enewuser "${PN}" -1 -1 /var/lib/"${PN}" "${PN}"

	readme.gentoo_print_elog
}
