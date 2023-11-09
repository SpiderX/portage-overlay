# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1 toolchain-funcs

COMMIT="469af6c925ea912eef7460303c3f3cd7b132e9ef"

DESCRIPTION="Ratelimit iptables module"
HOMEPAGE="https://github.com/aabc/ipt-ratelimit"
SRC_URI="https://github.com/aabc/ipt-ratelimit/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="net-firewall/iptables:0="
BDEPEND="virtual/linux-sources
	virtual/pkgconfig"

S="${WORKDIR}/ipt-ratelimit-${COMMIT}"

DOCS=( NEWS README )

src_prepare() {
	default

	# Replace make and gcc, add flags
	sed -i \
		-e 's:make -C:$(MAKE) -C:g' \
		-e 's:gcc -O2:$(CC) $(LDFLAGS):' \
		-e 's:gcc:$(CC) $(CFLAGS) $(LDFLAGS):' \
		Makefile || die "sed in Makefile failed"

	# https://github.com/aabc/ipt-ratelimit/pull/27/files
	sed -i 's/void _/static void __attribute__((constructor)) _/' \
		libxt_ratelimit.c || die "sed in libxt_ratelimit.c failed"

	if ! use debug; then
		sed 's/CFLAGS_xt_ratelimit.o := -DDEBUG//' \
			-i Makefile || die "sed for debug failed"
	fi
}

src_compile() {
	local modlist=( xt_ratelimit=ipt_ratelimit )
	local modargs=( KVER="${KV_FULL}" KDIR="${KV_OUT_DIR}" )
	emake CC="$(tc-getCC)" libxt_ratelimit.so
	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install
	exeinto /usr/"$(get_libdir)"/xtables
	doexe libxt_ratelimit.so
	doheader xt_ratelimit.h
}
