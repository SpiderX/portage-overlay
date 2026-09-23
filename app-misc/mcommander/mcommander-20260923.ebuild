# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools edo flag-o-matic optfeature

COMMIT="3c64bfce5adf2d01b20493d3918237a8077b1abd"

DESCRIPTION="M-Commander, based on GNU Midnight Commander"
HOMEPAGE="https://github.com/blue-panels/mcommander"
SRC_URI="https://github.com/blue-panels/mcommander/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+edit ftp gpm lua mongodb nls s3 samba sftp +slang spell sqlite static-libs test X"
REQUIRED_USE="spell? ( edit )"
RESTRICT="!test? ( test )"

CDEPEND="dev-libs/glib:2
	app-arch/libarchive:=
	sys-apps/file
	sys-fs/e2fsprogs
	virtual/zlib:=
	ftp? ( net-misc/curl )
	gpm? ( sys-libs/gpm )
	lua? ( dev-lang/lua:5.4 )
	mongodb? ( dev-libs/libbson
		dev-libs/mongo-c-driver )
	s3? ( net-misc/curl )
	samba? ( net-fs/samba[client] )
	sftp? ( net-libs/libssh2 )
	slang? ( sys-libs/slang )
	!slang? ( sys-libs/ncurses:= )
	sqlite? ( dev-db/sqlite:3 )
	X? ( x11-libs/libX11 )"
DEPEND="${CDEPEND}
	X? ( x11-base/xorg-proto )"
RDEPEND="${CDEPEND}
	dev-lang/perl
	!sftp? ( virtual/ssh )
	spell? ( || ( app-text/aspell
		app-text/hunspell ) )"
BDEPEND="dev-lang/perl
	sys-apps/groff
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
	test? ( dev-libs/check )"

PATCHES=( "${FILESDIR}/${PN}"-20260923-configure.patch
	"${FILESDIR}/${PN}"-20260923-Makefile.patch )

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	# autogen.sh generates POTFILES.in, which is not included
	use nls && edo xgettext --keyword={_,N_,Q_} --output=- \
		$(find lib maint src tests -name '*.[ch]') |
		sed -ne '/^#:/{s/#://;s/:[0-9]*/\n/g;s/ //g;p;}' |
		grep -v '^$' | sort -u > po/POTFILES.in

	eautoreconf
}

src_configure() {
	filter-lto

	econf --enable-mctree-magic=yes --enable-panel-plugin-arcmc=yes \
		--enable-ext2fs-attr --enable-panel-plugin-shell-link=yes \
		--enable-vfs --with-screen="$(usex slang slang ncurses)" \
		"$(use_enable ftp panel-plugin-ftp)" \
		"$(use_enable lua lua-plugin)" \
		"$(use_enable mongodb panel-plugin-mongo)" \
		"$(use_enable nls)" \
		"$(use_enable s3 panel-plugin-s3)" \
		"$(use_enable samba panel-plugin-samba)" \
		"$(use_enable sftp panel-plugin-sftp)" \
		"$(use_enable sftp shell-ssh2)" \
		"$(use_enable static-libs static)" \
		"$(use_enable sqlite panel-plugin-sqlite)" \
		"$(use_enable test tests)" \
		"$(use_with edit internal-edit)" \
		"$(use_with gpm gpm-mouse)" \
		"$(use_with X x)"
}

src_test() {
	# avoid inheriting MC_TMPDIR from a running MC/MCommander instance
	local -x MC_TMPDIR="${T}"

	default
}

src_install() {
	default

	find "${ED}"/usr/"$(get_libdir)"/mcommander/{panel,runtime}-plugins \
		-type f -name '*.la' -delete || die "removal failed"
}

pkg_postinst() {
	optfeature "integration with git" dev-vcs/git
	optfeature "integration with docker" app-containers/docker-cli
	optfeature "integration with kubernetes" sys-cluster/kubectl
	optfeature "integration with man pages" sys-apps/groff
	use lua && optfeature "support for image previews" "media-gfx/chafa[tools]"

	elog "To enable exiting to latest working directory,"
	elog "put this into your ~/.bashrc:"
	elog ". ${EPREFIX}/usr/libexec/mcommander/mc6.sh"
}
