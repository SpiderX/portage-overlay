# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit readme.gentoo-r1 linux-mod-r1 toolchain-funcs

MY_P="axt_NAT_v0_09_public_01_v6_patch"

DESCRIPTION="Assimetric NAT module for Linux xtables"
HOMEPAGE="https://forum.nag.ru/index.php?/topic/195398-anat-advanced-asymmetric-cg-nat-xt_anat-module-yadra-dlya-linux"
SRC_URI="${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="net-firewall/iptables:0="
BDEPEND="app-arch/p7zip
	virtual/linux-sources
	virtual/pkgconfig"

DOCS=( xt_NAT_doc.txt )

DOC_CONTENTS="Module can be used like this:\\n
iptables -t raw -A PREROUTING -d 11.103.133.0/24 -j ANAT --dnat\\n
iptables -A FORWARD -s 172.20.0.0/16 -i vlan3500 -o vlan102 -j ANAT --snat\\n"

pkg_nofetch() {
	einfo "Please download ${MY_P} from"
	einfo "${HOMEPAGE}"
	einfo "and place it into your DISTDIR directory"
}

src_prepare() {
	default

	# replace make and gcc, add flags
	sed -i \
		-e 's:make -C:$(MAKE) -C:g' \
		-e 's:gcc -O2:$(CC) $(CFLAGS) $(LDFLAGS):' \
		-e 's:gcc:$(CC) $(CFLAGS) $(LDFLAGS):' \
		Makefile || die "sed in Makefile failed"

	# fix typo
	sed -i 's/strlcpy/strncpy/' xt_ANAT_pc_work.c \
		|| die "sed failed for xt_ANAT_pc_work.c"

	if ! use debug; then
		sed 's/CFLAGS_xt_ANAT.o := -DDEBUG//' \
			-i Makefile || die "sed failed for debug"
	fi
}

src_compile() {
	local modlist=( xt_ANAT )
	local modargs=( KVER="${KV_FULL}" KDIR="${KV_OUT_DIR}" )
	emake ARCH="$(tc-arch-kernel)" CC="$(tc-getCC)" KVER="${KV_FULL}" \
		KDIR="${KV_OUT_DIR}" all
	linux-mod-r1_src_compile
}

src_install() {
	einstalldocs
	readme.gentoo_create_doc
	linux-mod-r1_src_install
	exeinto /usr/"$(get_libdir)"/xtables
	doexe libxt_ANAT.so
	doheader xt_ANAT.h
}

pkg_postinst() {
	linux-mod-r1_pkg_postinst
	readme.gentoo_print_elog
}
