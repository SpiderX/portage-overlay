# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1 toolchain-funcs

DESCRIPTION="Netfilter extension to match various DNS atributes"
HOMEPAGE="https://github.com/oskar456/xt_dns"
SRC_URI="https://github.com/oskar456/xt_dns/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="net-firewall/iptables:0="
BDEPEND="virtual/linux-sources
	virtual/pkgconfig"

src_prepare() {
	default

	sed -i  -e '/xt_match_param/s|$(KDIR)|/usr|' \
		-e '/CC/s|$(CC)|$(CC) $(CFLAGS) $(LDFLAGS)|' Makefile \
		|| die "sed failed"

	# fix build on iptables version 1.8.9 or newer
	sed -i 's/void _/static void __attribute__((constructor)) _/' \
		libxt_dns.c || die "sed for libxt_dns.c failed"
}

src_compile() {
	local modlist=( xt_dns )
	local modargs=( KVER="${KV_FULL}" KDIR="${KV_OUT_DIR}" )
	emake ARCH="$(tc-arch-kernel)" CC="$(tc-getCC)" KVERSION="${KV_FULL}" \
		KDIR="${KV_OUT_DIR}"
	linux-mod-r1_src_compile
}

src_install() {
	einstalldocs
	linux-mod-r1_src_install
	exeinto /usr/"$(get_libdir)"/xtables
	doexe libxt_dns.so
	doheader xt_dns.h
}
