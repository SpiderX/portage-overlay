# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit git-r3 eutils linux-info linux-mod multilib toolchain-funcs

EGIT_COMMIT="f706c84195a021d1b09e4a61a4d4050ebc56955f"
EGIT_REPO_URI="https://github.com/aabc/ipt-netflow.git"

DESCRIPTION="Netflow iptables module"
HOMEPAGE="https://sourceforge.net/projects/ipt-netflow"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE="pax_kernel"

RDEPEND="net-firewall/iptables"
DEPEND="${RDEPEND}
	virtual/linux-sources
	virtual/pkgconfig"

BUILD_TARGETS="all"
CONFIG_CHECK="~IP_NF_IPTABLES"
MODULE_NAMES="ipt_NETFLOW(ipt_netflow:${S})"

IPT_LIB="/usr/$(get_libdir)/xtables"

src_prepare() {
	sed -i -e 's:gcc -O2:$(CC) $(CFLAGS) $(LDFLAGS):' \
		-e 's:gcc:$(CC) $(CFLAGS) $(LDFLAGS):' Makefile.in || die 'sed on Makefile.in failed'

	# bug #455984
	epatch "${FILESDIR}"/${PN}-9999-configure.patch

	# bug #466430
	if use pax_kernel; then
		epatch "${FILESDIR}"/${PN}-1.8-pax-const.patch
	fi

	epatch_user
}

src_configure() {
	#local IPT_VERSION="$($(tc-getPKG_CONFIG) --modversion xtables)"
	# econf can not be used, cause configure script fails when see unknown parameter
	# ipt-src need to be defined, see bug #455984
	./configure \
		--ipt-lib="${IPT_LIB}" \
		--ipt-src="/usr/" \
		--ipt-ver="${IPT_VERSION}" \
		--kdir="${KV_DIR}" \
		--kver="${KV_FULL}" \
	|| die 'configure failed'
}

src_compile() {
	local ARCH="$(tc-arch-kernel)"
	emake CC="$(tc-getCC)" all
}

src_install() {
	linux-mod_src_install
	exeinto "${IPT_LIB}"
	doexe libipt_NETFLOW.so
	doheader ipt_NETFLOW.h
	dodoc README*
}
