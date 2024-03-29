# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/ianka/${PN}.git"

inherit git-r3

DESCRIPTION="An undelete tool for the XFS filesystem"
HOMEPAGE="https://github.com/ianka/xfs_undelete"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="dev-lang/tcl:0=
	dev-tcltk/tcllib
	sys-fs/xfsprogs"

src_prepare() {
	default

	mv xfs_undelete.{man,1} || die "mv failed"
}

src_install() {
	einstalldocs
	dobin xfs_undelete
	doman xfs_undelete.1
}
