# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://anonscm.debian.org/git/mirrorer/${PN}.git"

inherit git-r3

DESCRIPTION="A tool to handle local repositories of Debian packages"
HOMEPAGE="https://mirrorer.alioth.debian.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="archive bzip2 gpg lzma"

DEPEND="sys-libs/db:=
	sys-libs/zlib
	archive? ( app-arch/libarchive:0= )
	gpg? (
		app-crypt/gpgme:1=
		dev-libs/libgpg-error
	)
	lzma? ( app-arch/lzma )"
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		"$(use_with archive libarchive)" \
		"$(use_with bzip2 libbz2)" \
		"$(use_with gpg libgpgme)" \
		"$(use_with lzma liblzma)"
}
