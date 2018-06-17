# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="${PN/_/-}"
MY_P="${MY_PN}-${PV}"

inherit linux-info linux-mod toolchain-funcs

DESCRIPTION="Ratelimit iptables module"
HOMEPAGE="https://github.com/aabc/ipt-ratelimit"
SRC_URI="https://github.com/aabc/ipt-ratelimit/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="net-firewall/iptables:0="
DEPEND="${RDEPEND}
	virtual/linux-sources
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

DOCS=( NEWS README )

pkg_setup() {
	MODULE_NAMES="xt_ratelimit(ipt_ratelimit)"
	IPT_LIB="/usr/$(get_libdir)/xtables"
	linux-mod_pkg_setup
}

src_prepare() {
	default

	# Fix Makefile (remove last $), replace make and gcc, add flags
	sed -i \
		-e '/gcc -O2 -Wall -Wunused/s/.$//' \
		-e 's:make -C:$(MAKE) -C:g' \
		-e 's:gcc -O2:$(CC) $(CFLAGS) $(LDFLAGS):' \
		-e 's:gcc:$(CC) $(CFLAGS) $(LDFLAGS):' \
		Makefile || die "sed in Makefile failed"

	if ! use debug; then
		sed 's/CFLAGS_xt_ratelimit.o := -DDEBUG//' \
			-i Makefile || die "sed for debug failed"
	fi
}

src_compile() {
	emake ARCH="$(tc-arch-kernel)" CC="$(tc-getCC)" KVER="${KV_FULL}" all
}

src_install() {
	einstalldocs
	linux-mod_src_install
	exeinto "${IPT_LIB}"
	doexe libxt_ratelimit.so
	doheader xt_ratelimit.h
}
