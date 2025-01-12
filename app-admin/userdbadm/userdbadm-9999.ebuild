# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://gitlab.com/l3u/${PN}.git"

inherit git-r3

DESCRIPTION="Tool to manage (PAM) userdb files with crypted passwords"
HOMEPAGE="https://nasauber.de/opensource/userdbadm/"

LICENSE="GPL-2"
SLOT="0"

DEPEND="dev-lang/perl:0=[berkdb]
	virtual/perl-DB_File"
RDEPEND="${DEPEND}"

src_install() {
	einstalldocs
	dobin userdbadm
}
