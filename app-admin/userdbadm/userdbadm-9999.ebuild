# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="git://git.l3u.de/${PN}.git"

inherit git-r3

DESCRIPTION="Tool to manage (PAM) userdb files with crypted passwords"
HOMEPAGE="http://nasauber.de/opensource/userdbadm"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-lang/perl:0=[berkdb]
	virtual/perl-DB_File"
RDEPEND="${DEPEND}"

src_install() {
	default

	dobin userdbadm
}
