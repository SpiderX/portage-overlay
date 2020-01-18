# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools readme.gentoo-r1 systemd user

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

pkg_setup() {
	enewgroup automatic
	enewuser automatic -1 -1 /var/lib/automatic automatic
}

src_prepare() {
	default

	# https://bugs.gentoo.org/426262
	mv configure.{in,ac} || die "rename failed"

	# Remove CFLAGS and CXXFLAGS defined by upstream
	sed -i \
		-e 's/CFLAGS="-Wdeclaration-after-statement -O3 -funroll-loops"/CFLAGS+=""/' \
		-e 's/CXXFLAGS="-O3 -funroll-loops"/CXXFLAGS+=""/' \
		configure.ac || die "sed for CXXFLAGS and CFLAGS failed"

	# tests fail with network-sandbox
	rm src/tests/http_test.c || die "rm failed"

	eautoreconf
}

src_install() {
	default

	newinitd "${FILESDIR}"/automatic.initd automatic
	newconfd "${FILESDIR}"/automatic.confd automatic
	systemd_dounit "${FILESDIR}"/automatic.service

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/automatic.logrotate automatic

	readme.gentoo_create_doc

	diropts -oautomatic -gautomatic -m0700
	keepdir /var/lib/automatic/
	keepdir /var/log/automatic/
}

pkg_postinst() {
	readme.gentoo_print_elog
}
