# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit eutils

DESCRIPTION="Network problems simulator"
HOMEPAGE="https://github.com/tylertreat/Comcast"
SRC_URI="https://github.com/tylertreat/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lang/go:0="
DEPEND="${RDEPEND}"

export GOPATH="${S}"
export GOBIN="${D}/usr/bin/"

src_prepare() {
	# Use local path instead of url
	epatch "${FILESDIR}"/${P}-build.patch

	epatch_user
}

src_compile() {
	go build -v -x -work ${PN}.go || die
}

src_install() {
	go install -v -x -work ${PN}.go || die
}
