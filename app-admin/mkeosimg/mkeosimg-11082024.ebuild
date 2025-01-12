# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="d7441614e4c7e9f2f7a5d271ae46e6f633746a62"

DESCRIPTION="Ubiquiti EdgeOS image from a system tarball"
HOMEPAGE="https://github.com/sowbug/mkeosimg"
SRC_URI="https://github.com/sowbug/${PN}/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_install() {
	einstalldocs
	dobin mkeos{drive,img}
}
