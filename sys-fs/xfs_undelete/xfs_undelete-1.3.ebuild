# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="An undelete tool for the XFS filesystem"
HOMEPAGE="https://github.com/ianka/xfs_undelete"
SRC_URI="https://github.com/ianka/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/tcl-8.6:0=
	dev-tcltk/tcllib
	sys-fs/xfsprogs"

src_install() {
	einstalldocs
	dobin xfs_undelete
}
