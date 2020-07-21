# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/uroni/urbackup_backend.git"

inherit autotools git-r3 readme.gentoo-r1 systemd

DESCRIPTION="Client Server backup system"
HOMEPAGE="https://urbackup.org"
SRC_URI=""

LICENSE="AGPL-3+"
KEYWORDS=""
SLOT="0"
IUSE="cryptopp curl debug hardened fuse zlib"

# dev-lang/lua:5.3 masked, using embedded
DEPEND="acct-user/urbackup
	dev-db/lmdb:0=
	dev-db/sqlite:3
	cryptopp? ( dev-libs/crypto++:0= )
	curl? ( net-misc/curl )
	fuse? ( sys-fs/fuse:0 )
	zlib? ( sys-libs/zlib:0= )"
RDEPEND="${DEPEND}
	app-admin/logrotate"

DOC_CONTENTS="You may need to open the following ports in firewall:\\n
55413/tcp, 55414/tcp, 55415/tcp, 35623/udp
Default web-gui URL is http://localhost:55414/\\n\\n"

src_prepare() {
	default

	# Prepare files for server build
	cp "${S}"/Makefile.am_server "${S}"/Makefile.am \
		|| die "cp failed for Makefile.am_server"
	cp "${S}"/configure.ac_server "${S}"/configure.ac \
		|| die "cp failed for configure.ac_server"

	# Change Windows path to /tmp and disable client autoupdate
	sed -i  -e '/"backupfolder"/s|C:\\\\urbackup|/tmp|' \
		-e '/download_client/s/true/false/' \
		-e '/autoupdate_clients/s/true/false/' \
		urbackupserver/server_settings.cpp \
		|| die "sed failed for server_settings.cpp"
	# Remove key for client autoupdate and license
	sed -i  -e '/\/urbackup\/urbackup_ecdsa409k1.pub/d' \
		-e 's|urbackupserver/urbackup_ecdsa409k1.pub ||' \
		-e '/\/server-license.txt/d' \
		-e 's|server-license.txt ||' \
		Makefile.am || die "sed failed for Makefile.am"

	eautoreconf
}

src_configure() {
	econf "$(use_with cryptopp crypto)" \
		"$(use_with curl mail)" \
		"$(use_enable debug assertions)" \
		"$(use_with fuse mountvhd)" \
		"$(use_with zlib)" \
		"$(usex hardened --enable-fortify "")" \
		--enable-packaging \
		--without-embedded-lmdb \
		--without-embedded-sqlite3
}

src_install() {
	default

	doman docs/urbackupsrv.1

	insinto /etc/logrotate.d
	newins logrotate_urbackupsrv urbackup-server

	newinitd "${FILESDIR}"/urbackup-server.initd urbackup-server
	newconfd "${FILESDIR}"/urbackup-server.confd urbackup-server
	systemd_dounit "${FILESDIR}"/urbackup-server.service

	insinto /etc/urbackup
	doins "${FILESDIR}"/urbackup-server

	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
