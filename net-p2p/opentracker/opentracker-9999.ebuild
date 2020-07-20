# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/flygoast/${PN}.git"

MY_P="unofficial-v${PV}"

declare -A FLAGS
FLAGS=( [blacklist]="DWANT_ACCESSLIST_BLACK"
	[gzip]="DWANT_COMPRESSION_GZIP$"
	[gzip-always]="DWANT_COMPRESSION_GZIP_ALWAYS"
	[ip-from-query]="DWANT_IP_FROM_QUERY_STRING"
	[ip-from-proxy]="DWANT_IP_FROM_PROXY"
	[ipv6]="DWANT_V6"
	[fullscrapes]="DWANT_FULLSCRAPE"
	[fullscrapes-modest]="DWANT_MODEST_FULLSCRAPES"
	[live-sync]="DWANT_SYNC_LIVE"
	[live-sync-unicast]="DSYNC_LIVE_UNICAST"
	[log-networks-full]="DWANT_FULLLOG_NETWORKS"
	[log-numwant]="DWANT_LOG_NUMWANT"
	[persistence]="DWANT_PERSISTENCE"
	[spot-woodpeckers]="DWANT_SPOT_WOODPECKER"
	[syslog]="DWANT_SYSLOG"
	[restrict-stats]="DWANT_RESTRICT_STATS"
	[whitelist]="DWANT_ACCESSLIST_WHITE"
	[httpdebug]="DWANT_HTTPHUMAN"
)

inherit git-r3 systemd

DESCRIPTION="High-performance bittorrent tracker"
HOMEPAGE="https://github.com/flygoast/opentracker http://erdgeist.org/arts/software/opentracker/"
SRC_URI=""

LICENSE="BEER-WARE"
SLOT="0"
KEYWORDS=""
IUSE="blacklist debug +gzip gzip-always httpdebug ip-from-query ip-from-proxy ipv6 +fullscrapes fullscrapes-modest live-sync live-sync-unicast log-networks-full log-numwant persistence restrict-stats spot-woodpeckers syslog whitelist"
REQUIRED_USE="blacklist? ( !whitelist )
	gzip-always? ( gzip )
	gzip? ( fullscrapes )
	live-sync-unicast? ( live-sync )
	persistence? ( !ipv6 )"

RDEPEND="acct-user/opentracker
	dev-libs/libowfat
	gzip? ( sys-libs/zlib )"

src_prepare() {
	default

	# Fix use of FEATURES, so it's not mixed up with portage's FEATURES, and comment all of them
	# Define PREFIX, BINDIR and path to libowfat; remove lpthread, lz and O3 flag, owfat target, stripping; create dirs on install
	sed -i \
		-e "s|FEATURES|FEATURES_INTERNAL|g" \
		-e "s|^FEATURES_INTERNAL|#FEATURES_INTERNAL|g" \
		-e "s|PREFIX?=..|PREFIX?=/usr|g" \
		-e "s|LIBOWFAT_HEADERS=libowfat|LIBOWFAT_HEADERS=\$(PREFIX)/include/libowfat|g" \
		-e "s|-lpthread||g" \
		-e "s|-O3||g" \
		-e "s|-lz||g" \
		-e "s|strip \$@||g" \
		-e "s|BINDIR?=\$(PREFIX)/bin|BINDIR?=\$(DESTDIR)\$(PREFIX)/bin/|g" \
		-e "s|all: owfat|all:|g" \
		-e "s|install -m 755 ${PN} \$(BINDIR)|install -D -m 755 ${PN} \$(BINDIR)/${PN}|g" \
		Makefile || die "sed for src_prepare failed"

	# Define which features to use
	for flag in "${!FLAGS[@]}" ; do
		sed -i "$(usex "$flag" /"${FLAGS[$flag]}"/s/^#*// '')" Makefile || die "sed for $flag failed"
	done

	# Return back -lz flag for gzip
	sed -i "$(usex gzip /LDFLAGS+/s/$/-lz/ '')" Makefile || die "sed for lz in LDFLAGS failed"

	# Debug build: build opentracker.debug but target as opentracker, and don't build opentracker
	if use debug; then
		sed -i \
			-e "/D_DEBUG_HTTPERROR/s|^#*||g" \
			-e "s|all: \$(BINARY)|all:|g" \
			-e "s|\$@ \$(OBJECTS_debug)|opentracker \$(OBJECTS_debug)|g" \
		Makefile || die "sed for debug object failed"
	fi

	# Correct config paths
	sed -i \
		-e "/access.whitelist/s|/path/to/whitelist|/var/lib/${PN}/access.whitelist|g" \
		-e "/access.blacklist/s|./blacklist|/var/lib/${PN}/access.blacklist|g" \
		-e "/tracker.rootdir/s|/usr/local/etc/opentracker|/var/lib/${PN}|g" \
		-e "/tracker.user/s|nobody|${PN}|g" \
		-e "/persist.file/s|/path/to/persist.odb|/var/lib/${PN}/${PN}.odb|g" \
	opentracker.conf.sample || die "sed for config failed"
}

src_install() {
	default

	doman "${FILESDIR}"/opentracker.8

	newinitd "${FILESDIR}"/opentracker.initd opentracker
	newconfd "${FILESDIR}"/opentracker.confd opentracker
	systemd_dounit "${FILESDIR}"/opentracker.service

	insopts -m 640 -o opentracker -g opentracker
	insinto /etc/opentracker
	newins opentracker.conf.sample opentracker.conf
}
