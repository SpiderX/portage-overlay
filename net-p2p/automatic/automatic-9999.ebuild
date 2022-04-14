# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/1100101/${PN^}.git"

inherit autotools git-r3 readme.gentoo-r1 systemd

DESCRIPTION="RSS downloader for Tranmission"
HOMEPAGE="https://github.com/1100101/Automatic"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="acct-user/automatic
	dev-libs/libxml2:2
	dev-libs/libpcre:3
	net-misc/curl"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

DOC_CONTENTS="To run automatic you should move /etc/automatic.conf-sample
to /etc/automatic.conf and config it.\\n
If things go wrong, increase verbose level in /etc/conf.d/automatic
and check log file in /var/log/automatic/\\n"

src_prepare() {
	default

	# remove CFLAGS and CXXFLAGS defined by upstream
	sed -i  -e '/CFLAGS=/s/=".*"/+=""/' \
		-e '/CXXFLAGS=/s/=".*"/+=""/' \
		configure.ac || die "sed failed for configure.ac"

	# provide test api keys for tests
	sed -i '/correct_key/s|""|"05b363d4561aaaa5c4c49bbb15639068b8cb6646"|' \
		src/tests/prowl_test.c || die "sed failed for prowl_test.c"
	# disable pushover tests
	sed -i '/check_PROGRAMS /s/ pushover_test//' src/tests/Makefile.am \
		|| die "sed failed for src/tests/Makefile.am"

	# wrt #836740
	sed -i '/stdio.h/i#include <stdint.h>' src/tests/utils_test.c \
		|| die "sed failed for utils_test.c"

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

	diropts -o automatic -g automatic -m 0700
	keepdir /var/log/automatic/
}

pkg_postinst() {
	readme.gentoo_print_elog
}
