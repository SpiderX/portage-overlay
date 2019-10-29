# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/ianka/${PN}.git"

inherit git-r3

DESCRIPTION="An undelete tool for the XFS filesystem"
HOMEPAGE="https://github.com/ianka/xfs_undelete"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=dev-lang/tcl-8.6:0=
	dev-tcltk/tcllib
	sys-fs/xfsprogs"

src_install() {
	einstalldocs
	dobin xfs_undelete
}
