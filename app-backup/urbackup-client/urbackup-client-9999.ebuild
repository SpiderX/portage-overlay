# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/uroni/urbackup_backend.git"
PLOCALES="cs da de es fa fr it nl pl pt_BR ru sk uk zh_CN zh_TW"
PLOCALE_BACKUP="en"
WX_GTK_VER="3.2-gtk3"

inherit autotools git-r3 plocale systemd wxwidgets

DESCRIPTION="Client Server backup system"
HOMEPAGE="https://www.urbackup.org/"

LICENSE="AGPL-3+"
SLOT="0"
IUSE="debug hardened nls X zlib zstd"

RDEPEND="acct-group/urbackup
	acct-user/urbackup
	app-arch/zstd:=
	dev-db/sqlite:3
	dev-libs/crypto++:0=
	dev-libs/icu:0=
	sys-libs/zlib:0=
	X? ( x11-libs/wxGTK:${WX_GTK_VER}[X] )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	nls? ( sys-devel/gettext )"

PATCHES=( "${FILESDIR}/${PN}"-2.5.25-gcc13.patch )

src_prepare() {
	default

	# Prepare files for server build
	cp "${S}"/Makefile.am_client "${S}"/Makefile.am \
		|| die "cp failed for Makefile.am_server"
	cp "${S}"/configure.ac_client "${S}"/configure.ac \
		|| die "cp failed for configure.ac_server"

	eautoreconf
}

src_configure() {
	econf --disable-clientupdate \
		--without-embedded-sqlite3 \
		"$(use_enable debug assertions)" \
		"$(use_enable hardened fortify)" \
		"$(use_enable !X headless)" \
		"$(use_with zlib)" \
		"$(use_with zstd)"
	use X && setup-wxwidgets
}

src_install() {
	default

	doman docs/urbackupclientbackend.1

	keepdir /var/lib/urbackup/data

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/urbackup-client.logrotate urbackup-client

	newinitd "${FILESDIR}"/urbackup-client.initd urbackup-client
	newconfd "${FILESDIR}"/urbackup-client.confd urbackup-client
	systemd_dounit "${FILESDIR}"/urbackup-client.service

	insinto /etc/urbackup
	doins "${FILESDIR}"/urbackup-client
}
