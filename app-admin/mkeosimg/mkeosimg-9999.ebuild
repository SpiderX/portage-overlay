# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Ubiquiti EdgeOS image from a system tarball"
HOMEPAGE="https://github.com/sowbug/mkeosimg"

LICENSE="MIT"
SLOT="0"

src_install() {
	einstalldocs
	dobin mkeos{drive,img}
}
