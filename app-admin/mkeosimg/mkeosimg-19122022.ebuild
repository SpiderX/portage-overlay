# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="c96fff2323ab4b76ae0c48a601cc90098b61374c"

DESCRIPTION="Ubiquiti EdgeOS image from a system tarball"
HOMEPAGE="https://github.com/sowbug/mkeosimg"
SRC_URI="https://github.com/sowbug/${PN}/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${PN}-${COMMIT}"

src_install() {
	einstalldocs
	dobin mkeos{drive,img}
}
