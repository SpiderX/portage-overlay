# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

COMMIT="71b18b636b9c7d1ae0c1d3730b85b3c127eb4511"

DESCRIPTION="A tool for measuring perceived differences between images"
HOMEPAGE="https://github.com/google/butteraugli"
SRC_URI="https://github.com/google/${PN}/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="media-libs/libjpeg-turbo:=
	media-libs/libpng:=
	sys-libs/zlib:="

src_compile() {
	cd butteraugli || die "faild to change dir"
	emake CXX="$(tc-getCXX)"
}

src_install() {
	einstalldocs
	dobin butteraugli/butteraugli
}
