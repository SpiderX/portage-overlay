# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit golang-base

DESCRIPTION="Network problems simulator"
HOMEPAGE="https://github.com/tylertreat/comcast"
SRC_URI="https://github.com/tylertreat/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lang/go:0="
DEPEND="${RDEPEND}"

# Use local path instead of url
PATCHES=( "${FILESDIR}"/${P}-build.patch )

src_compile() {
	GOPATH="${S}:$(get_golibdir_gopath)" go build -v -ldflags \
		"-X main.version=${PV}" -x -work ${PN}.go || die "build failed"
}

src_install() {
	default

	GOBIN="${D}/usr/bin/" go install -v -ldflags \
		"-X main.version=${PV}" -x -work ${PN}.go || die "install failed"
}
