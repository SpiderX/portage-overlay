# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 linux-mod-r1 toolchain-funcs

DESCRIPTION="Full Cone NAT module for Linux iptables"
HOMEPAGE="https://github.com/gonarh/xt_NAT_with_netflow_v9"
EGIT_REPO_URI="https://github.com/gonarh/xt_NAT_with_netflow_v9.git"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

RDEPEND="net-firewall/iptables:0="
BDEPEND="virtual/linux-sources
	virtual/pkgconfig"

src_prepare() {
	default

	# replace make and gcc, add flags
	sed -i \
		-e 's:make -C:$(MAKE) -C:g' \
		-e 's:gcc -O2:$(CC) $(CFLAGS) $(LDFLAGS):' \
		-e 's:gcc:$(CC) $(CFLAGS) $(LDFLAGS):' \
		Makefile || die "sed in Makefile failed"

	# workaround build
	sed -i '/void sk_error_report/s|static ||' \
		xt_NAT.c || die "sed failed for xt_NAT.c"

	if ! use debug; then
		sed 's/CFLAGS_xt_NAT.o := -DDEBUG//' \
			-i Makefile || die "sed failed for debug"
	fi
}

src_compile() {
	local modlist=( xt_NAT )
	local modargs=( KVER="${KV_FULL}" KDIR="${KV_OUT_DIR}" )
	emake ARCH="$(tc-arch-kernel)" CC="$(tc-getCC)" KVER="${KV_FULL}" \
		KDIR="${KV_OUT_DIR}" all
	linux-mod-r1_src_compile
}

src_install() {
	einstalldocs
	linux-mod-r1_src_install
	exeinto /usr/"$(get_libdir)"/xtables
	doexe libxt_NAT.so
	doheader xt_NAT.h
}
