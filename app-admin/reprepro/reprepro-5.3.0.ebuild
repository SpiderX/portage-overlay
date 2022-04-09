# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A tool to handle local repositories of Debian packages"
HOMEPAGE="https://salsa.debian.org/brlink/reprepro"
SRC_URI="https://ftp.debian.org/debian/pool/main/r/${PN}/${P/-/_}.orig.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
