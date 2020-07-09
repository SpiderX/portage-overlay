# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/aabc/pkt-netflow.git"

inherit git-r3 linux-info linux-mod toolchain-funcs

DESCRIPTION="NetFlow v5, v9, IPFIX flow data exporter"
HOMEPAGE="https://github.com/aabc/pkt-netflow"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="snmp"

DEPEND="snmp? ( net-analyzer/net-snmp )"
RDEPEND="${DEPEND}"
BDEPEND="virtual/linux-sources
	virtual/pkgconfig"

DOCS=( NEWS README )

CONFIG_CHECK="BRIDGE_NETFILTER ~IP_NF_IPTABLES VLAN_8021Q"
BUILD_TARGETS="all"
MODULE_NAMES="pkt_netflow(pkt_netflow:${S})"

src_prepare() {
	default

	# fix jobserver and CFLAGS and LDFLAGS in makefile
	sed  -i -e "s/CC = gcc/\$(CC) ?= $(tc-getCC)/" \
		-e 's/make -C $(KDIR)/$(MAKE) -C $(KDIR)/g' \
		-e 's/$(CC) -fPIC/$(CC) $(CFLAGS) $(LDFLAGS) -fPIC/' \
		-e 's/$(CC) -shared/$(CC) $(CFLAGS) $(LDFLAGS) -shared/' \
		Makefile.in || die "sed failed for Makefile.in"
	# add parameters to work with econf
	sed  -i -e '/case "$ac_option" in/a    --prefix=*) ;;' \
		-e '/case "$ac_option" in/a    --build=*) ;;' \
		-e '/case "$ac_option" in/a    --host=*) ;;' \
		-e '/case "$ac_option" in/a    --mandir=*) ;;' \
		-e '/case "$ac_option" in/a    --infodir=*) ;;' \
		-e '/case "$ac_option" in/a    --datadir=*) ;;' \
		-e '/case "$ac_option" in/a    --sysconfdir=*) ;;' \
		-e '/case "$ac_option" in/a    --localstatedir=*) ;;' \
		-e '/case "$ac_option" in/a    --libdir=*) ;;' \
		-e '/--disable-net-snmp/s/net-snmp/snmp-rules/' \
		configure || die "sed failed for configure"
}

src_configure() {
	econf \
		--disable-dkms \
		--enable-aggregation \
		--enable-direction \
		--enable-macaddress \
		--promisc-mpls \
		--promisc-mpls=3 \
		--enable-sampler \
		--enable-sampler=hash \
		--enable-vlan \
		--kver="${KV_FULL}" \
		--kdir="${KV_OUT_DIR}" \
		"$(use_enable snmp snmp-rules)"
}

src_install() {
	einstalldocs
	linux-mod_src_install
	use snmp && emake DESTDIR="${D}" SNMPTGSO="/usr/$(get_libdir)/snmp/dlmod/snmp_NETFLOW.so" sinstall
	doheader pkt_netflow.h
}
