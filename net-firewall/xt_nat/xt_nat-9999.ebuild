# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/andrsharaev/${PN}.git"

inherit git-r3 linux-info linux-mod toolchain-funcs

DESCRIPTION="Full Cone NAT module for Linux iptables"
HOMEPAGE="https://github.com/andrsharaev/xt_NAT"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug"

RDEPEND="net-firewall/iptables:0="
BDEPEND="virtual/linux-sources
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}"/"${P}"-kernel-5.patch
	"${FILESDIR}"/"${P}"-printf.patch
	# https://forum.nag.ru/index.php?/topic/150616-assymetric-nat-na-linux/
	"${FILESDIR}"/"${P}"-natevents.patch )

pkg_setup() {
	MODULE_NAMES="xt_NAT(xt_NAT)"
	IPT_LIB="/usr/$(get_libdir)/xtables"
	linux-mod_pkg_setup
}

src_prepare() {
	default

	# Replace make and gcc, add flags
	sed -i \
		-e 's:make -C:$(MAKE) -C:g' \
		-e 's:gcc -O2:$(CC) $(CFLAGS) $(LDFLAGS):' \
		-e 's:gcc:$(CC) $(CFLAGS) $(LDFLAGS):' \
		Makefile || die "sed in Makefile failed"

	kernel_is -ge 5 4 && eapply "${FILESDIR}"/"${P}"-kernel-5.4.patch

	if ! use debug; then
		sed 's/CFLAGS_xt_NAT.o := -DDEBUG//' \
			-i Makefile || die "sed for debug failed"
	fi
}

src_compile() {
	emake ARCH="$(tc-arch-kernel)" CC="$(tc-getCC)" KVER="${KV_FULL}" \
		KDIR="${KV_OUT_DIR}" all
}

src_install() {
	einstalldocs
	linux-mod_src_install
	exeinto "${IPT_LIB}"
	doexe libxt_NAT.so
	doheader xt_NAT.h
}
