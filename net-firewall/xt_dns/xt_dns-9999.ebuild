# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/oskar456/${PN}.git"

inherit git-r3 linux-info linux-mod toolchain-funcs

DESCRIPTION="Netfilter extension to match various DNS atributes"
HOMEPAGE="https://github.com/oskar456/xt_dns"
SRC_URI=""

LICENSE="GPL-1"
SLOT="0"
KEYWORDS=""

RDEPEND="net-firewall/iptables:0="
BDEPEND="virtual/linux-sources
	virtual/pkgconfig"

pkg_setup() {
	MODULE_NAMES="xt_dns(xt_dns)"
	XDIR="/usr/$(get_libdir)/xtables"
	linux-mod_pkg_setup
}

src_prepare() {
	default

	sed -i  -e '/xt_match_param/s|$(KDIR)|/usr|' \
		-e '/CC/s|$(CC)|$(CC) $(CFLAGS) $(LDFLAGS)|' Makefile \
		|| die "sed failed"
}

src_compile() {
	emake ARCH="$(tc-arch-kernel)" CC="$(tc-getCC)" KVERSION="${KV_FULL}" \
		KDIR="${KV_OUT_DIR}"
}

src_install() {
	einstalldocs
	linux-mod_src_install
	exeinto "${XDIR}"
	doexe libxt_dns.so
	doheader xt_dns.h
}
