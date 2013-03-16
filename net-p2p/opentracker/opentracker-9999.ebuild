# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit cvs

ECVS_USER="anoncvs"
ECVS_SERVER="cvs.erdgeist.org:/home/cvsroot"
ECVS_MODULE="${PN}"

DESCRIPTION="High-performance bittorrent tracker"
HOMEPAGE="http://erdgeist.org/arts/software/opentracker/"
LICENSE="BEER-WARE"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="blacklist debug examples +gzip gzip_always ip_from_query ip_from_proxy ipv6 +fullscrapes fullscrapes_modest live_sync log_networks_full log_numwant restrict_stats spot_woodpeckers syslog random whitelist"

RDEPEND=">=dev-libs/libowfat-0.27
	gzip? ( sys-libs/zlib )"

S=${WORKDIR}/${ECVS_MODULE}

REQUIRED_USE="blacklist? ( !whitelist )
	gzip_always? ( gzip )
	gzip? ( fullscrapes )
"

pkg_setup() {
	# Add opentracker group and user to system
	# (no home directory specified, because otherwise it will be result in opentracker:root ownership on it)
	enewgroup ${PN}
	enewuser ${PN} -1 -1 ${PN}
}

src_prepare() {
	# Fix use of FEATURES, so it's not mixed up with portage's FEATURES
	# Define PREFIX, BINDIR and path to libowfat, remove lpthread, lz and O3 flag, create dirs on install
	sed -i \
		-e "s|FEATURES|FEATURES_INTERNAL|g" \
		-e "s|PREFIX?=..|PREFIX?=/usr|g" \
		-e "s|LIBOWFAT_HEADERS=\$(PREFIX)/libowfat|LIBOWFAT_HEADERS=\$(PREFIX)/include/libowfat|g" \
		-e "s|-lpthread||g" \
		-e "s|-O3||g" \
		-e "s|-lz||g" \
		-e "s|BINDIR?=\$(PREFIX)/bin|BINDIR?=\$(DESTDIR)\$(PREFIX)/bin/|g" \
		-e "s|install -m 755 ${PN} \$(BINDIR)|install -D -m 755 ${PN} \$(BINDIR)/${PN}|g" \
		Makefile || die "sed for src_prepare failed"

	if use blacklist ; then
		sed -i '/DWANT_ACCESSLIST_BLACK/s/^#*//' Makefile || die "sed for blacklist failed"
	fi

	if use gzip ; then
		# Bring back lz flag to build with gzip support
		sed -i \
			-e '/DWANT_COMPRESSION_GZIP$/s|^#*||g' \
			-e '/LDFLAGS+/s|$|-lz|g' \
			Makefile || die "sed for gzip failed"
	fi

	if use gzip_always ; then
		sed -i '/DWANT_COMPRESSION_GZIP_ALWAYS/s/^#*//' Makefile || die "sed for gzip_always failed"
	fi

	if use ip_from_query ; then
		sed -i '/DWANT_IP_FROM_QUERY_STRING/s/^#*//' Makefile || die "sed for ip_from_query failed"
	fi

	if use ip_from_proxy ; then
		sed -i '/DWANT_IP_FROM_PROXY/s/^#*//' Makefile || die "sed for ip_from_proxy failed"
	fi

	if use ipv6 ; then
		sed -i '/DWANT_V6/s/^#*//' Makefile || die "sed for ipv6 failed"
	fi

	if use fullscrapes ; then
		sed -i '/DWANT_FULLSCRAPE/s/^#*//' Makefile || die "sed for fullscrapes failed"
	fi

	if use fullscrapes_modest ; then
	sed -i '/DWANT_MODEST_FULLSCRAPES/s/^#*//' Makefile || die "sed for fullscrapes_modest failed"
	fi

	if use live_sync ; then
	sed -i '/DWANT_SYNC_LIVE/s/^#*//' Makefile || die "sed for live_sync failed"
	fi

	if use log_networks_full ; then
		sed -i '/DWANT_FULLLOG_NETWORKS/s/^#*//' Makefile || die "sed for log_networks_full failed"
	fi

	if use log_numwant ; then
		sed -i '/DWANT_LOG_NUMWANT/s/^#*//' Makefile || die "sed for log_numwant failed"
	fi

	if use spot_woodpeckers ; then
		sed -i '/DWANT_SPOT_WOODPECKER/s/^#*//' Makefile || die "sed for spot_woodpeckers failed"
	fi

	if use syslog ; then
		sed -i '/DWANT_SYSLOG/s/^#*//' Makefile || die "sed for syslog failed"
	fi

	if use random ; then
		sed -i '/DWANT_DEV_RANDOM/s/^#*//' Makefile || die "sed for random failed"
	fi

	if use restrict_stats ; then
		sed -i '/DWANT_RESTRICT_STATS/s/^#*//' Makefile || die "sed for restrict_stats failed"
	fi

	if use whitelist ; then
		sed -i '/DWANT_ACCESSLIST_WHITE/s/^#*//' Makefile || die "sed for whitelist failed"
	fi

	# Debug build: build opentracker.debug but target as opentracker, and don't build opentracker
	if use debug; then
		sed -i \
			-e '/D_DEBUG_HTTPERROR/s|^#*||g' \
			-e 's|all: $(BINARY)|all:|g' \
			-e 's|$@ $(OBJECTS_debug)|opentracker $(OBJECTS_debug)|g' \
		Makefile || die "sed for debug object failed"
	fi
}

src_install() {
	# Install and copy documentation
	default

	# Install Gentoo init script and its config
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}

	# Install manual page
	#doman "${FILESDIR}"/${PN}.8

	# Install config
	insinto /etc/${PN}
	newins "${S}"/${PN}.conf.sample ${PN}.conf

	if use examples ; then
		# Install files into specified directory
		insinto /usr/share/${PN}
		doins -r "${S}"/tests/*.sh
		doins "${S}"/sync_daemon.pl
	fi

	# Correct user,group and permissions for files and directories
	fowners -R ${PN}:${PN} /etc/${PN}
	fperms 0640 /etc/${PN}/${PN}.conf
}